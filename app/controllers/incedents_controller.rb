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
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Книга жалоб"+(params[:status_id] ? " (по статусу '"+Status.find(params[:status_id]).name+"')" : '')+(params[:server_id] ? " (по оборудованию '"+Server.find(params[:server_id]).name+"')" : '')+(params[:type_id] ? " (по типу '"+Type.find(params[:type_id]).name+"')" : '')+(params[:priority_id] ? " (по приоритету '"+Priority.find(params[:priority_id]).name+"')" : '')+(params[:tag_id] ? " (по метке '"+Tag.find(params[:tag_id]).name+"')" : '')+(params[:user_id] ? " (по пользователю '"+User.find(params[:user_id]).realname+"')" : '')+".xls\"" }
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
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Архив жалоб"+(params[:server_id] ? " (по оборудованию '"+Server.find(params[:server_id]).name+"')" : '')+(params[:type_id] ? " (по типу '"+Type.find(params[:type_id]).name+"')" : '')+(params[:priority_id] ? " (по приоритету '"+Priority.find(params[:priority_id]).name+"')" : '')+(params[:tag_id] ? " (по метке '"+Tag.find(params[:tag_id]).name+"')" : '')+(params[:user_id] ? " (по пользователю '"+User.find(params[:user_id]).realname+"')" : '')+".xls\"" }
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
    @attach = Attach.new
  end

  # POST /incedent/:id/comment
  def comment
    @incedent_comment = IncedentComment.new(incedent: Incedent.find(params[:incedent_comment][:incedent_id]), comment: Comment.new(params[:incedent_comment][:comment]))
    @incedent_comment.comment.author = @current_user

    respond_to do |format|
      if @incedent_comment.save

        if params[:incedent_comment][:comment][:attaches_attributes]
          params[:incedent_comment][:comment][:attaches_attributes].each do |key, attach|
            if attach[:file].present?
              save_comment_attach(@incedent_comment.comment, attach)
            end
          end
        end

        IncedentMailer.incedent_commented(@incedent_comment).deliver

        format.html { redirect_to @incedent_comment.incedent, notice: 'Коментарий успешно добавлен.' }
      else
        format.html { render action: 'show' }
      end
    end
  end

  # POST /incedent/:incedent_id/comment/:comment_id/delete
  def delete_comment
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

    respond_to do |format|
        format.html { redirect_to incedent_comments_path(Incedent.find(params[:incedent_id])), notice: 'Коментарий успешно удален.' }
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
        format.html { render action: 'new' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /incedent/add
  # POST /incedent/add.json
  def add
    @incedent = Incedent.new(params[:incedent].except(:attaches_attributes))
  
    respond_to do |format|
      if @incedent.save

        if params[:incedent][:attaches_attributes]
          params[:incedent][:attaches_attributes].each do |key, attach|
            if attach[:file].present?
              save_incedent_attach(@incedent, attach)
            end
          end
        end

        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.initiator).save

        if (@incedent.worker)
          IncedentAction.create(incedent: @incedent, status: Status.find(Houston::Application.config.incedent_played), worker: @incedent.worker).save
        end

        IncedentMailer.incedent_created(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно создана.' }
        format.json { render json: @incedent, status: :created, location: @incedent }
      else
        format.html { render action: 'new' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /incedents/1
  # PUT /incedents/1.json
  def update
    @incedent = Incedent.find(params[:id])
    
    if params[:incedent][:attaches_attributes]
      params[:incedent][:attaches_attributes].each do |key, attach|
        if attach[:file].present?
          save_incedent_attach(@incedent, attach)
          params[:incedent][:attaches_attributes].delete key
        end
      end
    end

    respond_to do |format|
      if @incedent.update_attributes(params[:incedent])

        if (@incedent.worker)
          IncedentAction.create(incedent: @incedent, status: Status.find(Houston::Application.config.incedent_played), worker: @incedent.worker).save
        end

        IncedentMailer.incedent_changed(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      format.html { redirect_to :incedents, notice: 'Жалоба успешно удалена.' }
      format.json { head :no_content }
    end
  end

  # GET /incedent/1/play
  # GET /incedent/1/play.json
  def play
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user
    @incedent.played!

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_played(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно принята в работу.' }
        format.json { head :no_content }
      else
        format.html { render action: 'play' }
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
      @incedent.played!

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба возобновлена', body: params[:incedent][:replay_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.worker).save
  
          IncedentMailer.incedent_replayed(@incedent).deliver
  
          format.html { redirect_to :incedents, notice: 'Жалоба успешно возобновлена.' }
          format.json { head :no_content }
        else
          format.html { render action: 'replay' }
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

  # GET /incedent/1/work
  # GET /incedent/1/work.json
  def work
    if !params[:incedent][:work_reason].empty? and !params[:incedent][:worker_id].empty?
      @incedent = Incedent.find(params[:id])

      @incedent.worker = User.find(params[:incedent][:worker_id])
      @incedent.played!

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба назначена исполнителю', body: params[:incedent][:work_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.worker).save

          IncedentMailer.incedent_worked(@incedent).deliver

          format.html { redirect_to :incedents, notice: 'Жалоба успешно передана в работу.' }
          format.json { head :no_content }
        else
          format.html { render action: 'work' }
          format.json { render json: @incedent.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html {  redirect_to :incedents, alert: 'Нужно обязательно указать причину передачи.' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/pause
  # GET /incedent/1/pause.json
  def pause
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?
    @incedent.paused!

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_paused(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно приостановлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'pause' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/stop
  # GET /incedent/1/stop.json
  def stop
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?
    @incedent.stoped!

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_stoped(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно остановлена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'stop' }
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
      @incedent.rejected!

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба отклонена', body: params[:incedent][:reject_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

          IncedentMailer.incedent_rejected(@incedent).deliver

          format.html { redirect_to :incedents, notice: 'Жалоба успешно отклонена.' }
          format.json { head :no_content }
        else
          format.html { render action: 'reject' }
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
    @incedent.solved!

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_solved(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно решена.' }
        format.json { head :no_content }
      else
        format.html { render action: 'solve' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /incedent/1/close
  # GET /incedent/1/close.json
  def close
    if !params[:incedent][:close_reason].empty? 
      @incedent = Incedent.find(params[:id])
  
      @incedent.worker = @current_user unless @incedent.has_worker?
      @incedent.closed!

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба закрыта', body: params[:incedent][:close_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save
  
          IncedentMailer.incedent_closed(@incedent).deliver
  
          format.html { redirect_to :incedents, notice: 'Жалоба успешно закрыта.' }
          format.json { head :no_content }
        else
          format.html { render action: 'close' }
          format.json { render json: @incedent.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html {  redirect_to :incedents, alert: 'Нужно обязательно указать причину закрытия.' }
        format.json { render json: @incedent.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def save_incedent_attach(incedent, attach)
    uploaded_io = attach[:file]

    Dir.mkdir(Rails.root.join('public', 'uploads', 'incedents', incedent.id.to_s), 0777) unless Dir.exists?(Rails.root.join('public', 'uploads', 'incedents', incedent.id.to_s))

    File.open(Rails.root.join('public', 'uploads', 'incedents', incedent.id.to_s, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @attach = Attach.new(name: uploaded_io.original_filename, description: attach[:description], mime: uploaded_io.content_type, size: File.size(Rails.root.join('public', 'uploads', 'incedents', incedent.id.to_s, uploaded_io.original_filename)))
    @attach.save

    @incedent_attach = IncedentAttach.new(incedent: incedent, attach: @attach)

    @incedent_attach.save
  end

  def save_comment_attach(comment, attach)
    uploaded_io = attach[:file]

    Dir.mkdir(Rails.root.join('public', 'uploads', 'comments', comment.id.to_s), 0777) unless Dir.exists?(Rails.root.join('public', 'uploads', 'comments', comment.id.to_s))

    File.open(Rails.root.join('public', 'uploads', 'comments', comment.id.to_s, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @attach = Attach.new(name: uploaded_io.original_filename, description: attach[:description], mime: uploaded_io.content_type, size: File.size(Rails.root.join('public', 'uploads', 'comments', comment.id.to_s, uploaded_io.original_filename)))
    @attach.save

    @comment_attach = CommentAttach.new(comment: comment, attach: @attach)
    @comment_attach.save
  end

  def get_incedents(archive)
    (params[:tag_id]) ?
      Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_tag(Tag.find(params[:tag_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC') :
        if (params[:status_id] and params[:type_id] and params[:priority_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:type_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:priority_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:type_id] and params[:priority_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:type_id] and params[:priority_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:type_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:priority_id] and params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_priority(Priority.find(params[:priority_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:type_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_type(Type.find(params[:type_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:priority_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:type_id] and params[:priority_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_type(Type.find(params[:type_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_status(Status.find(params[:status_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:type_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_type(Type.find(params[:type_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:priority_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_priority(Priority.find(params[:priority_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:user_id] and params[:server_id])
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).incedents_by_user(User.find(params[:user_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        elsif (params[:status_id] and params[:type_id] and params[:priority_id] and params[:user_id])
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
        elsif params[:server_id]
          Incedent.accessible_by(current_ability).solved_incedents(archive).incedents_by_server(Server.find(params[:server_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        else
          Incedent.accessible_by(current_ability).solved_incedents(archive).paginate(page: params[:page], per_page: 5).order('updated_at DESC')
        end
  end

end
