# encoding: utf-8
class AttachesController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /attaches
  # GET /attaches.json
  def index
    @attaches = Attach.accessible_by(current_ability).paginate(page: params[:page], per_page: 10).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

end
