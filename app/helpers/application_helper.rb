# encoding: utf-8
module ApplicationHelper

  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def badge(text, aclass = '')
    content_tag :span, text, class: 'badge'+((aclass != '') ? ' badge-'+aclass.to_s : '')
  end

  def lbl(text, aclass = '')
    content_tag :span, text, class: 'label'+((aclass != '') ? ' label-'+aclass.to_s : '')
  end

  def show_status(status)
    case status
      when Houston::Application.config.incedent_created
        glyph(:file)
      when Houston::Application.config.incedent_played
        glyph(:play)
      when Houston::Application.config.incedent_paused
        glyph(:pause)
      when Houston::Application.config.incedent_stoped
        glyph(:stop)
      when Houston::Application.config.incedent_rejected
        glyph(:remove)
      when Houston::Application.config.incedent_solved
        glyph(:thumbs_up)
      when Houston::Application.config.incedent_closed
        glyph(:ok)
      when Houston::Application.config.incedent_waited
        glyph(:time)
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true, prettify: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: true,
        tables: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def gravatar_url(user)
    if user.email.present?
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    end
  end

  def add_object_link(name, form, object, partial, where)
    html = render partial: partial, locals: { f: form}, object: object

    link_to_function name, %{
      var new_object_id = new Date().getTime() ;
      var html = jQuery(#{html.to_json}.replace(/XXX/g, new_object_id)).hide();
      html.appendTo(jQuery("#{where}")).slideDown('slow');
    }, class: 'btn btn-mini'
  end

  def link_to_attach_for_server(server, attach)
    link_to glyph(:file)+' '+attach.name+' ('+attach.size.to_s+')', url_to_attach_for_server(server, attach), title: attach.description,  class: 'btn btn-mini'
  end

  def link_to_attach_for_incedent(incedent, attach)
   link_to glyph(:file)+' '+attach.name+' ('+attach.size.to_s+')', url_to_attach_for_incedent(incedent, attach), title: attach.description,  class: 'btn btn-mini'
  end

  def link_to_attach_for_document(document, attach)
   link_to glyph(:file)+' '+attach.name+' ('+attach.size.to_s+')', url_to_attach_for_document(document, attach), title: attach.description,  class: 'btn btn-mini'
  end

  def link_to_attach_for_comment(comment, attach)
   link_to glyph(:file)+' '+attach.name+' ('+attach.size.to_s+')', url_to_attach_for_comment(comment, attach), title: attach.description,  class: 'btn btn-mini'
  end

  def url_to_attach_for_server(server, attach)
    "#{root_url}uploads/servers/#{server.id}/"+attach.name
  end

  def url_to_attach_for_incedent(incedent, attach)
   "#{root_url}uploads/incedents/#{incedent.id}/"+attach.name
  end

  def url_to_attach_for_document(document, attach)
   "#{root_url}uploads/documents/#{document.id}/"+attach.name
  end

  def url_to_attach_for_comment(comment, attach)
   "#{root_url}uploads/comments/#{comment.id}/"+attach.name
  end

  def url_to_attach(attach)
    if !attach.incedents.empty? then
      url_to_attach_for_incedent(attach.incedents.first, attach)
    else
      if !attach.comments.empty? then
        url_to_attach_for_comment(attach.comments.first, attach)
      else
        if !attach.documents.empty? then
          url_to_attach_for_document(attach.documents.first, attach)
        else
          if !attach.servers.empty? then
            url_to_attach_for_server(attach.servers.first, attach)
          else
            '#'
          end
        end
      end
    end
  end

  def url_to_source(attach)
    if !attach.incedents.empty? then
      attach.incedents.first
    else
      if !attach.comments.empty? then
        if !attach.comments.first.documents.empty? then
          document_url(attach.comments.first.documents.first, anchor: attach.comments.first.id.to_s)
        else
          if !attach.comments.first.incedents.empty? then
            incedent_url(attach.comments.first.incedents.first, anchor: attach.comments.first.id.to_s)
          else
            if !attach.servers.empty? then
              server_url(attach.servers.first, anchor: attach.servers.first.id.to_s)
            else
              ''
            end
          end
        end
      else
        if !attach.documents.empty? then
          attach.documents.first
        else
          if !attach.servers.empty? then
            attach.servers.first
          else
            ''
          end
        end
      end
    end
  end

  def link_to_attach_source(attach)
    link_to glyph(:inbox)+' Источник', url_to_source(attach), class: 'btn btn-mini'
  end

  def send_jabber_message(to, subject, text)
    Jabber::debug = true if Rails.env.development?

    def reconnect(cl)
      cl.connect
      cl.auth(Houston::Application.config.JabberPSWD)
      cl.send(Jabber::Presence.new.set_show(:chat).set_status(Houston::Application.config.app_name))
    end

    jid = Jabber::JID.new(Houston::Application.config.JabberID+'/'+Houston::Application.config.app_name)
    client = Jabber::Client.new(jid)
    client.on_exception { sleep 5; reconnect(client) }

    reconnect(client)

    # Send an Instant Message.
    to_jid = Jabber::JID.new(to)
    message = Jabber::Message::new(to_jid, text).set_type(:normal).set_id('1').set_subject(subject)
    client.send(message)

    client.close! if client.is_connected?
  end

  def get_incedents(archive)
    Incedent.scoped.
        accessible_by(current_ability).
        solved(archive).
        by_tag(params[:tag_id]).
        by_parent(params[:parent_id]).
        by_status(params[:status_id]).
        by_type(params[:type_id]).
        by_priority(params[:priority_id]).
        by_user_as_initiator_or_worker(params[:user_id]).
        by_server(params[:server_id])
  end

end
