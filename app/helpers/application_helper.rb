module ApplicationHelper

  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "icon-#{name.to_s.gsub('_','-')}" }
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
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
  
  def link_to_attach_for_incedent(incedent, attach)
   link_to glyph(:file)+' '+attach.name, "#{root_url}uploads/incedents/#{incedent.id}/"+attach.name, title: attach.description,  class: 'btn btn-mini'
  end

  def link_to_attach_for_document(document, attach)
   link_to glyph(:file)+' '+attach.name, "#{root_url}uploads/documents/#{document.id}/"+attach.name, title: attach.description,  class: 'btn btn-mini'
  end

  def link_to_attach_for_comment(comment, attach)
   link_to glyph(:file)+' '+attach.name, "#{root_url}uploads/comments/#{comment.id}/"+attach.name, title: attach.description,  class: 'btn btn-mini'
  end
end
