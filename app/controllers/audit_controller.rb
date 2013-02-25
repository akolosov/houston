# encoding: utf-8
class AuditController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  def index
    @audits = Audit.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
end
