# encoding: utf-8
class IncedentsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /incedents
  # GET /incedents.json
  def index
    @incedents = get_incedents(false)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @incedents }
      format.csv { send_data @incedents.to_csv(col_sep: "\t") }
      format.xls
    end
  end

  # GET /incedents/archive
  # GET /incedents/archive.json
  def archive
    @incedents = get_incedents(true)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @incedents }
      format.csv { send_data @incedents.to_csv(col_sep: "\t") }
      format.xls
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

        IncedentMailer.incedent_commented(@incedent_comment).deliver

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
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.initiator).save

        IncedentMailer.incedent_created(@incedent).deliver

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

  # GET /incedent/1/play
  # GET /incedent/1/play.json
  def play
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user

    @incedent.status_id = Houston::Application.config.incedent_played

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_played(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно принята в работу.' }
        format.json { head :no_content }
      else
        format.html { render action: "play" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/replay
  # GET /incedent/1/replay.json
  def replay
    if !params[:incedent][:replay_reason].empty? 
      @incedent = Incedent.find(params[:id])
  
      @incedent.worker = @current_user unless @incedent.has_worker?
  
      @incedent.status_id = Houston::Application.config.incedent_played
      @incedent.closed = false

      @incedent_comment = IncedentComment.new
      @incedent_comment.incedent = @incedent
      @incedent_comment.comment = Comment.new(title: 'Жалоба возобновлена', body: params[:incedent][:replay_reason], author: @current_user)
      @incedent_comment.save  
  
      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.worker).save
  
          IncedentMailer.incedent_replayed(@incedent).deliver
  
          format.html { redirect_to :incedents, notice: 'Жалоба успешно возобновлена.' }
          format.json { head :no_content }
        else
          format.html { render action: "replay" }
          format.json { render json: @incedent.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html {  redirect_to :incedents, alert: 'Нужно обязательно указать причину возобновления.' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/pause
  # GET /incedent/1/pause.json
  def pause
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_paused

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_paused(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно приостановлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "pause" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/stop
  # GET /incedent/1/stop.json
  def stop
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_stoped

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_stoped(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно остановлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "stop" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/reject
  # GET /incedent/1/reject.json
  def reject
    if !params[:incedent][:reject_reason].empty? 
      @incedent = Incedent.find(params[:id])

      @incedent.worker = @current_user unless @incedent.has_worker?
  
      @incedent.status_id = Houston::Application.config.incedent_rejected
  
      @incedent_comment = IncedentComment.new
      @incedent_comment.incedent = @incedent
      @incedent_comment.comment = Comment.new(title: 'Жалоба отклонена', body: params[:incedent][:reject_reason], author: @current_user)
      @incedent_comment.save
  
      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save
  
          IncedentMailer.incedent_rejected(@incedent).deliver
  
          format.html { redirect_to :incedents, notice: 'Жалоба успешно отклонена.' }
          format.json { head :no_content }
        else
          format.html { render action: "reject" }
          format.json { render json: @incedent.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html {  redirect_to :incedents, alert: 'Нужно обязательно указать причину отклонения.' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/solve
  # GET /incedent/1/solve.json
  def solve
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?
    @incedent.closed = true

    @incedent.status_id = Houston::Application.config.incedent_solved

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_solved(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно решена.' }
        format.json { head :no_content }
      else
        format.html { render action: "solve" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/close
  # GET /incedent/1/close.json
  def close
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?

    @incedent.status_id = Houston::Application.config.incedent_closed

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_closed(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно закрыта.' }
        format.json { head :no_content }
      else
        format.html { render action: "close" }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def get_incedents(archive)
    (params[:tag_id]) ?
      Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_tag(Tag.find(params[:tag_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC') :
      if (params[:status_id] and params[:type_id] and params[:priority_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:type_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:priority_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:type_id] and params[:priority_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:type_id] and params[:priority_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:type_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_type(Type.find(params[:type_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:priority_id] and params[:user_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:type_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:status_id] and params[:priority_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif (params[:type_id] and params[:priority_id])
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif params[:status_id]
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_status(Status.find(params[:status_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif params[:type_id]
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_type(Type.find(params[:type_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif params[:priority_id]
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      elsif params[:user_id]
        Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      else
        Incedent.accessible_by(current_ability).solved_incedents(archive).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
      end
  end

end
