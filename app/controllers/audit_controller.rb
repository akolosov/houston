class AuditController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  def index
    @audits = Audit.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end
end
