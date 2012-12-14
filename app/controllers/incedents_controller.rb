# encoding: utf-8
class IncedentsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /incedents
  # GET /incedents.json
  def index
    if (params[:tag_id])
      @incedents = Incedent.accessible_by(current_ability).incedents_by_tag(Tag.find(params[:tag_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
    else
      if (params[:status_id] and params[:type_id] and params[:priority_id]) 
        @incedents = Incedent.accessible_by(current_ability).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Status.find(params[:type_id])).incedents_by_priority(Status.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:type_id]) 
        @incedents = Incedent.accessible_by(current_ability).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Status.find(params[:type_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:priority_id]) 
        @incedents = Incedent.accessible_by(current_ability).incedents_by_status(Status.find(params[:status_id])).incedents_by_priority(Status.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:type_id] and params[:priority_id]) 
        @incedents = Incedent.accessible_by(current_ability).incedents_by_type(Status.find(params[:type_id])).incedents_by_priority(Status.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id]) 
        @incedents = Incedent.accessible_by(current_ability).incedents_by_status(Status.find(params[:status_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:type_id])
        @incedents = Incedent.accessible_by(current_ability).incedents_by_type(Type.find(params[:type_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:priority_id])
        @incedents = Incedent.accessible_by(current_ability).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      else
        @incedents = Incedent.accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      end
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

    @incedent_comment = IncedentComment.new
    @incedent_comment.comment = Comment.new
    @incedent_comment.comment.author = @current_user
    @incedent_comment.incedent = @incedent

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
    @incedent.status_id = Houston::Application.config.incedent_created

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @incedent }
    end
  end

  # GET /incedents/1/edit
  def edit
    @incedent = Incedent.find(params[:id])
  end

  # POST /incedent/:id/comment
  def comment
    @incedent_comment = IncedentComment.new
    @incedent_comment.incedent = Incedent.find(params[:incedent_comment][:incedent_id])
    @incedent_comment.comment = Comment.new(params[:incedent_comment][:comment])
    @incedent_comment.comment.author = @current_user

    respond_to do |format|
      if @incedent_comment.save
        format.html { redirect_to @incedent_comment.incedent, notice: 'Коментарий успешно добавлен.' }
      else
        format.html { render action: "show" }
      end
    end
  end

  # POST /incedents
  # POST /incedents.json
  def create
    @incedent = Incedent.new(params[:incedent])

    respond_to do |format|
      if @incedent.save
        format.html { redirect_to :incedents, notice: 'Жалоба успешно создана.' }
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
        format.html { redirect_to :incedents, notice: 'Жалоба успешно обновлена.' }
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

  # GET /incedents/1/play
  # GET /incedents/1/play.json
  def play
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user

    @incedent.status_id = Houston::Application.config.incedent_played

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно принята в работу.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedents/1/replay
  # GET /incedents/1/replay.json
  def replay
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_played

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.worker).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно возобновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedents/1/pause
  # GET /incedents/1/pause.json
  def pause
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_paused

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно приостановлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedents/1/stop
  # GET /incedents/1/stop.json
  def stop
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_stoped

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно остановлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedents/1/reject
  # GET /incedents/1/reject.json
  def reject
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_rejected

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно отклонена.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedents/1/solve
  # GET /incedents/1/solve.json
  def solve
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_solved

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно решена.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedents/1/close
  # GET /incedents/1/close.json
  def close
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_closed

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        format.html { redirect_to :incedents, notice: 'Жалоба успешно закрыта.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

end
