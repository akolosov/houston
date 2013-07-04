# encoding: utf-8
module IncedentsHelper

  def make_user_filter_url(user, status_id, type_id, priority_id, server_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    status = (status_id ? Status.find(status_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to user.realname, ((type and priority and status and server) ? incedents_by_status_and_priority_and_type_and_user_and_server_path(status, priority, type, user, server) :
        ((type and status and server) ? incedents_by_status_and_type_and_user_and_server_path(status, type, user, server) :
            ((priority and status and server) ? incedents_by_status_and_priority_and_user_and_server_path(status, priority, user, server) :
                ((status and server) ? incedents_by_status_and_user_and_server_path(status, user, server) :
                    ((type and priority and status) ? incedents_by_status_and_priority_and_type_and_user_path(status, priority, type, user) :
                        ((status and type) ? incedents_by_status_and_type_and_user_path(status, type, user) :
                            ((type and priority) ? incedents_by_priority_and_type_and_user_path(priority, type, user) :
                                (status ? incedents_by_status_and_user_path(status, user) :
                                    (type ? incedents_by_type_and_user_path(type, user) :
                                        (priority ? incedents_by_priority_and_user_path(priority, user) :
                                            (server ? incedents_by_user_and_server_path(user, server) :
                                                incedents_by_user_path(user)))))))))))),
            remote: true, class: 'btn btn-mini' + (params[:user_id] == user.id.to_s ? ' btn-success disabled' : '')
  end

  def make_status_filter_url(status, type_id, priority_id, user_id, server_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to status.name, ((type and priority and user and server) ? incedents_by_status_and_priority_and_type_and_user_and_server_path(status, priority, type, user, server) :
        ((type and user and server) ? incedents_by_status_and_type_and_user_and_server_path(status, type, user, server) :
            ((priority and user and server) ? incedents_by_status_and_priority_and_user_and_server_path(status, priority, user, server) :
                ((type and priority and server) ? incedents_by_status_and_priority_and_type_and_server_path(status, priority, type, server) :
                    ((user and server) ? incedents_by_status_and_user_and_server_path(status, user, server) :
                        ((type and server) ? incedents_by_status_and_type_and_server_path(status, type, server) :
                            ((priority and server) ? incedents_by_status_and_priority_and_server_path(status, priority, server) :
                                ((type and priority and user) ? incedents_by_status_and_priority_and_type_and_user_path(status, priority, type, user) :
                                    ((type and user) ? incedents_by_status_and_type_and_user_path(status, type, user) :
                                        ((priority and user) ? incedents_by_status_and_priority_and_user_path(status, priority, user) :
                                            ((type and priority) ? incedents_by_status_and_priority_and_type_path(status, priority, type) :
                                                (user ? incedents_by_status_and_user_path(status, user) :
                                                    (type ? incedents_by_status_and_type_path(status, type) :
                                                        (priority ? incedents_by_status_and_priority_path(status, priority) :
                                                            (server ? incedents_by_status_and_server_path(status, server) :
                                                                incedents_by_status_path(status)))))))))))))))),
            remote: true, class: 'btn btn-mini' + (params[:status_id] == status.id.to_s ? ' btn-success disabled' : '')
  end

  def make_server_filter_url(server, type_id, priority_id, user_id, status_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    status = (status_id ? Status.find(status_id) : nil)

    link_to server.name, ((type and priority and user and status) ? incedents_by_status_and_priority_and_type_and_user_and_server_path(status, priority, type, user, server) :
        ((type and user and status) ? incedents_by_status_and_type_and_user_and_server_path(status, type, user, server) :
            ((priority and user and status) ? incedents_by_status_and_priority_and_user_and_server_path(status, priority, user, server) :
                ((type and priority and status) ? incedents_by_status_and_priority_and_type_and_server_path(status, priority, type, server) :
                    ((user and status) ? incedents_by_status_and_user_and_server_path(status, user, server) :
                        ((type and status) ? incedents_by_status_and_type_and_server_path(status, type, server) :
                            ((priority and status) ? incedents_by_status_and_priority_and_server_path(status, priority, server) :
                                (user ? incedents_by_user_and_server_path(user, server) :
                                    (type ? incedents_by_type_and_server_path(type, server) :
                                        (priority ? incedents_by_priority_and_server_path(priority, server) :
                                            incedents_by_server_path(server))))))))))),
            remote: true, class: 'btn btn-mini' + (params[:server_id] == server.id.to_s ? ' btn-success disabled' : '')
  end


  def make_priority_filter_url(priority, status_id, type_id, user_id, server_id)
    type = (type_id ? Type.find(type_id) : nil)
    status = (status_id ? Status.find(status_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to priority.name, ((type and status and user and server) ? incedents_by_status_and_priority_and_type_and_user_and_server_path(status, priority, type, user, server) :
        ((status and user and server) ? incedents_by_status_and_priority_and_user_and_server_path(status, priority, user, server) :
            ((type and status and server) ? incedents_by_status_and_priority_and_type_and_server_path(status, priority, type, server) :
                (server ? incedents_by_priority_and_server_path(priority, server) :
                    ((status and type and user) ? incedents_by_status_and_priority_and_type_and_user_path(status, priority, type, user) :
                        ((type and user) ? incedents_by_priority_and_type_and_user_path(priority, type, user) :
                            ((status and user) ? incedents_by_status_and_priority_and_user_path(status, priority, user) :
                                ((status and type) ? incedents_by_status_and_priority_and_type_path(status, priority, type) :
                                    (user ? incedents_by_priority_and_user_path(priority, user) :
                                        (type ? incedents_by_priority_and_type_path(priority, type) :
                                            (status ? incedents_by_status_and_priority_path(status, priority) :
                                                incedents_by_priority_path(priority)))))))))))),
            remote: true, class: 'btn btn-mini' + (params[:priority_id] == priority.id.to_s ? ' btn-success disabled' : '')
  end

  def make_type_filter_url(type, status_id, priority_id, user_id, server_id)
    status = (status_id ? Status.find(status_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to type.name, ((status and priority and user and server) ? incedents_by_status_and_priority_and_type_and_user_and_server_path(status, priority, type, user, server) :
        ((status and user and server) ? incedents_by_status_and_type_and_user_and_server_path(status, type, user, server) :
            ((status and priority and server) ? incedents_by_status_and_priority_and_type_and_server_path(status, priority, type, server) :
                ((status and server) ? incedents_by_status_and_type_and_server_path(status, type, server) :
                    ((status and priority and user) ? incedents_by_status_and_priority_and_type_and_user_path(status, priority, type, user) :
                        ((priority and user) ? incedents_by_priority_and_type_and_user_path(priority, type, user) :
                            ((status and user) ? incedents_by_status_and_type_and_user_path(status, type, user) :
                                ((status and priority) ? incedents_by_status_and_priority_and_type_path(status, priority, type) :
                                    (user ? incedents_by_type_and_user_path(type, user) :
                                        (priority ? incedents_by_priority_and_type_path(priority, type) :
                                            (status ? incedents_by_status_and_type_path(status, type) :
                                                (server ? incedents_by_type_and_server_path(type, server) :
                                                    incedents_by_type_path(type))))))))))))),
            remote: true, class: 'btn btn-mini'+(params[:type_id] == type.id.to_s ? ' btn-success disabled' : '')
  end

  def make_archive_user_filter_url(user, type_id, priority_id, server_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to user.realname, ((type and priority and server) ? incedents_archive_by_priority_and_type_and_user_and_server_path(priority, type, user, server) :
        ((type and server) ? incedents_archive_by_type_and_user_and_server_path(type, user, server) :
            ((priority and server) ? incedents_archive_by_priority_and_user_and_server_path(priority, user, server) :
                ((type and priority) ? incedents_archive_by_priority_and_type_and_user_path(priority, type, user) :
                    (type ? incedents_archive_by_type_and_user_path(type, user) :
                        (priority ? incedents_archive_by_priority_and_user_path(priority, user) :
                            (server ? incedents_archive_by_user_and_server_path(user, server) :
                                incedents_archive_by_user_path(user)))))))),
            remote: true, class: 'btn btn-mini' + (params[:user_id] == user.id.to_s ? ' btn-success disabled' : '')
  end

  def make_archive_server_filter_url(server, type_id, priority_id, user_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    user = (user_id ? User.find(user_id) : nil)

    link_to server.name, ((type and priority and user) ? incedents_archive_by_priority_and_type_and_user_and_server_path(priority, type, user, server) :
        ((type and user) ? incedents_archive_by_type_and_user_and_server_path(type, user, server) :
            ((priority and user) ? incedents_archive_by_priority_and_user_and_server_path(priority, user, server) :
                ((type and priority) ? incedents_archive_by_priority_and_type_and_server_path(priority, type, server) :
                    (type ? incedents_archive_by_type_and_server_path(type, server) :
                        (priority ? incedents_archive_by_priority_and_user_path(priority, server) :
                            (user ? incedents_archive_by_user_and_server_path(user, server) :
                                incedents_archive_by_server_path(server)))))))),
            remote: true, class: 'btn btn-mini' + (params[:server_id] == server.id.to_s ? ' btn-success disabled' : '')
  end

  def make_archive_priority_filter_url(priority, type_id, user_id, server_id)
    type = (type_id ? Type.find(type_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to priority.name, ((type and user and server) ? incedents_archive_by_priority_and_type_and_user_and_server_path(priority, type, user, server) :
        ((user and server) ? incedents_archive_by_priority_and_user_and_server_path(priority, user, server) :
            ((type and server) ? incedents_archive_by_priority_and_type_and_server_path(priority, type, server) :
                ((type and user) ? incedents_archive_by_priority_and_type_and_user_path(priority, type, user) :
                    (user ? incedents_archive_by_priority_and_user_path(priority, user) :
                        (type ? incedents_archive_by_priority_and_type_path(priority, type) :
                            (server ? incedents_archive_by_priority_and_server_path(priority, server) :
                                incedents_archive_by_priority_path(priority)))))))),
            remote: true, class: 'btn btn-mini' + (params[:priority_id] == priority.id.to_s ? ' btn-success disabled' : '')
  end

  def make_archive_type_filter_url(type, priority_id, user_id, server_id)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to type.name, ((priority and user and server) ? incedents_archive_by_priority_and_type_and_user_and_server_path(priority, type, user, server) :
        ((user and server) ? incedents_archive_by_type_and_user_and_server_path(type, user, server) :
            ((priority and server) ? incedents_archive_by_priority_and_type_and_server_path(priority, type, server) :
                ((priority and user) ? incedents_archive_by_priority_and_type_and_user_path(priority, type, user) :
                    (user ? incedents_archive_by_type_and_user_path(type, user) :
                        (priority ? incedents_archive_by_priority_and_type_path(priority, type) :
                            (server ? incedents_archive_by_type_and_server_path(type, server) :
                                incedents_archive_by_type_path(type)))))))),
            remote: true, class: 'btn btn-mini'+(params[:type_id] == type.id.to_s ? ' btn-success disabled' : '')
  end

  def make_download_url(status_id, type_id, priority_id, tag_id, user_id, server_id)
    status = (status_id ? Status.find(status_id) : nil)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    tag = (tag_id ? Tag.find(tag_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to glyph(:download)+' Скачать', ((status and type and priority and user and server) ? incedents_by_status_and_priority_and_type_and_user_and_server_path(status, priority, type, user, server, :xls) :
        ((status and type and user and server) ? incedents_by_status_and_type_and_user_and_server_path(status, type, user, server, :xls) :
            ((status and priority and user and server) ? incedents_by_status_and_priority_and_user_and_server_path(status, priority, user, server, :xls) :
                ((type and priority and user and server) ? incedents_by_priority_and_type_and_user_and_server_path(priority, type, user, server, :xls) :
                    ((status and user and server) ? incedents_by_status_and_user_and_server_path(status, user, server, :xls) :
                        ((priority and user and server) ? incedents_by_priority_and_user_and_server_path(priority, user, server, :xls) :
                            ((type and user and server) ? incedents_by_type_and_user_and_server_path(type, user, server, :xls) :
                                ((status and type and priority and server) ? incedents_by_status_and_priority_and_type_and_server_path(status, priority, type, server, :xls) :
                                    ((status and type and server) ? incedents_by_status_and_type_and_server_path(status, type, server, :xls) :
                                        ((status and priority and server) ? incedents_by_status_and_priority_and_server_path(status, priority, server, :xls) :
                                            ((type and priority and server) ? incedents_by_priority_and_type_and_server_path(priority, type, server, :xls) :
                                                ((status and server) ? incedents_by_status_and_serverpath(status, server, :xls) :
                                                    ((priority and server) ? incedents_by_priority_and_server_path(priority, server, :xls) :
                                                        ((type and server) ? incedents_by_type_and_server_path(type, server, :xls) :
                                                            ((user and server) ? incedents_by_user_and_server_path(user, server, :xls) :
                                                                ((status and type and priority and user) ? incedents_by_status_and_priority_and_type_and_user_path(status, priority, type, user, :xls) :
                                                                    ((status and type and user) ? incedents_by_status_and_type_and_user_path(status, type, user, :xls) :
                                                                        ((status and priority and user) ? incedents_by_status_and_priority_and_user_path(status, priority, user, :xls) :
                                                                            ((type and priority and user) ? incedents_by_priority_and_type_and_user_path(priority, type, user, :xls) :
                                                                                ((status and user) ? incedents_by_status_and_user_path(status, user, :xls) :
                                                                                    ((priority and user) ? incedents_by_priority_and_user_path(priority, user, :xls) :
                                                                                        ((type and user) ? incedents_by_type_and_user_path(type, user, :xls) :
                                                                                            ((status and type and priority) ? incedents_by_status_and_priority_and_type_path(status, priority, type, :xls) :
                                                                                                ((status and type) ? incedents_by_status_and_type_path(status, type, :xls) :
                                                                                                    ((status and priority) ? incedents_by_status_and_priority_path(status, priority, :xls) :
                                                                                                        ((type and priority) ? incedents_by_priority_and_type_path(priority, type, :xls) :
                                                                                                            (status ? incedents_by_status_path(status, :xls) :
                                                                                                                (priority ? incedents_by_priority_path(priority, :xls) :
                                                                                                                    (type ? incedents_by_type_path(type, :xls) :
                                                                                                                        (user ? incedents_by_user_path(user, :xls) :
                                                                                                                            (server ? incedents_by_server_path(server, :xls) :
                                                                                                                                (tag ? incedents_by_tag_path(tag, :xls) :
                                                                                                                                    incedents_path(:xls))))))))))))))))))))))))))))))))),
            class: 'btn btn-mini'
  end


  def make_archive_download_url(type_id, priority_id, tag_id, user_id, server_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)
    tag = (tag_id ? Tag.find(tag_id) : nil)
    user = (user_id ? User.find(user_id) : nil)
    server = (server_id ? Server.find(server_id) : nil)

    link_to glyph(:download)+' Скачать', ((type and priority and user and server) ? incedents_archive_by_priority_and_type_and_user_and_server_path(priority, type, user, server, :xls) :
        ((priority and user and server) ? incedents_archive_by_priority_and_user_and_server_path(priority, user, server, :xls) :
            ((type and user and server) ? incedents_archive_by_type_and_user_and_server_path(type, user, server, :xls) :
                ((type and priority and server) ? incedents_archive_by_priority_and_type_and_server_path(priority, type, server, :xls) :
                    ((priority and server) ? incedents_archive_by_priority_and_server_path(priority, server, :xls) :
                        ((type and server) ? incedents_archive_by_type_and_server_path(type, server, :xls) :
                            ((user and server) ? incedents_archive_by_user_and_server_path(user, server, :xls) :
                                ((tag and server) ? incedents_archive_by_tag_and_server_path(tag, server, :xls) :
                                    ((type and priority and user) ? incedents_archive_by_priority_and_type_and_user_path(priority, type, user, :xls) :
                                        ((priority and user) ? incedents_archive_by_priority_and_user_path(priority, user, :xls) :
                                            ((type and user) ? incedents_archive_by_type_and_user_path(type, user, :xls) :
                                                ((type and priority) ? incedents_archive_by_priority_and_type_path(priority, type, :xls) :
                                                    (priority ? incedents_archive_by_priority_path(priority, :xls) :
                                                        (type ? incedents_archive_by_type_path(type, :xls) :
                                                            (user ? incedents_archive_by_user_path(user, :xls) :
                                                                (server ? incedents_archive_by_server_path(server, :xls) :
                                                                    (tag ? incedents_archive_by_tag_path(tag, :xls) :
                                                                        incedents_archive_path(:xls)))))))))))))))))),
            class: 'btn btn-mini'
  end

end
