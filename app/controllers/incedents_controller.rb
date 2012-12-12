# encoding: utf-8
class IncedentsController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  # GET /incedents
  # GET /incedents.json
  def index
    if (params[:tag_id])
      @incedents = Incedent.incedents_by_tag(Tag.find(params[:tag_id])).paginate(page: params[:page], per_page: 10).order('updated_at DESC')
    else
      @incedents = Incedent.accessible_by(current_ability).paginate(page: params[:page], per_page: 10).order('updated_at DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incedents }
    end
  end

  # GET /incedents/1
  # GET /incedents/1.json
  def show
    @incedent = Incedent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @incedent }
    end
  end

  # GET /incedents/new
  # GET /incedents/new.json
  def new
    @incedent = Incedent.new

    @incedent.initiator = @current_user
    @incedent.status = Status.find(1)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @incedent }
    end
  end

  # GET /incedents/1/edit
  def edit
    @incedent = Incedent.find(params[:id])
  end

  # POST /incedents
  # POST /incedents.json
  def create
    @incedent = Incedent.new(params[:incedent])

    respond_to do |format|
      if @incedent.save
        format.html { redirect_to :incedents, notice: 'Incedent was successfully created.' }
        format.json { render json: @incedent, status: :created, location: @incedent }
      else
        format.html { render action: "new" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /incedents/1
  # PUT /incedents/1.json
  def update
    @incedent = Incedent.find(params[:id])

    respond_to do |format|
      if @incedent.update_attributes(params[:incedent])
        format.html { redirect_to :incedents, notice: 'Incedent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incedents/1
  # DELETE /incedents/1.json
  def destroy
    @incedent = Incedent.find(params[:id])
    @incedent.destroy

    respond_to do |format|
      format.html { redirect_to incedents_url }
      format.json { head :no_content }
    end
  end
end
