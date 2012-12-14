module IncedentsHelper

  def make_status_filter_url(status, priority_id, type_id)
    type = (type_id ? Type.find(type_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)

    link_to status.name, (type and priority ? incedents_by_status_and_priority_and_type_path(status, priority, type) :
                         (type ? incedents_by_status_and_type_path(status, type) :
                         (priority ? incedents_by_status_and_priority_path(status, priority) :
                         incedents_by_status_path(status)))),
    class: 'btn btn-mini' + (params[:status_id] == status.id.to_s ? ' btn-success' : '')
  end

  def make_priority_filter_url(priority, status_id, type_id)
    type = (type_id ? Type.find(type_id) : nil)
    status = (status_id ? Status.find(status_id) : nil)

    link_to priority.name, (status and type ? incedents_by_status_and_priority_and_type_path(status, priority, type) :
                           (type ? incedents_by_priority_and_type_path(priority, type) :
                           (status ? incedents_by_status_and_priority_path(status, priority) :
                           incedents_by_priority_path(priority)))),
    class: 'btn btn-mini' + (params[:priority_id] == priority.id.to_s ? ' btn-success' : '')
  end

  def make_type_filter_url(type, status_id, priority_id)
    status = (status_id ? Status.find(status_id) : nil)
    priority = (priority_id ? Priority.find(priority_id) : nil)

    link_to type.name, (status and priority ? incedents_by_status_and_priority_and_type_path(status, priority, type) :
                       (priority ? incedents_by_priority_and_type_path(priority, type) :
                       (status ? incedents_by_status_and_type_path(status, type) :
                       incedents_by_type_path(type)))),
    class: 'btn btn-mini'+(params[:type_id] == type.id.to_s ? ' btn-success' : '')
  end

end
