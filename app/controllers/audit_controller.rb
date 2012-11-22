class AuditController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  def index
    @audits = Audit.order("created_at DESC").limit(10)
  end
end
