# encoding: utf-8
class IncedentsController < ApplicationController
  include TheSortableTreeController::Rebuild
  include ApplicationHelper

  before_filter :require_login, :set_per_page

  load_and_authorize_resource

  attr_accessor :per_page

  # GET /incedents
  # GET /incedents.json
  def index
    @incedents = get_incedents(false).nested_set.paginate(page: params[:page], per_page: @per_page).order('finish_at')

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.csv { send_data @incedents.to_csv(col_sep: "\t") }
      format.xls {
        @incedents = get_incedents(false).order('finish_at')
        headers["Content-Disposition"] = "attachment; filename=\"Книга жалоб"+(params[:status_id] ? " (по статусу '"+Status.find(params[:status_id]).name+"')" : '')+(params[:server_id] ? " (по оборудованию '"+Server.find(params[:server_id]).name+"')" : '')+(params[:type_id] ? " (по типу '"+Type.find(params[:type_id]).name+"')" : '')+(params[:priority_id] ? " (по приоритету '"+Priority.find(params[:priority_id]).name+"')" : '')+(params[:tag_id] ? " (по метке '"+Tag.find(params[:tag_id]).name+"')" : '')+(params[:user_id] ? " (по пользователю '"+User.find(params[:user_id]).realname+"')" : '')+".xls\""
      }
    end
  end

  # GET /incedents/archive
  # GET /incedents/archive.json
  def archive
    @incedents = get_incedents(true).paginate(page: params[:page], per_page: @per_page).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.csv { send_data @incedents.to_csv(col_sep: "\t") }
      format.xls {
        @incedents = get_incedents(true).order('updated_at DESC')
        headers["Content-Disposition"] = "attachment; filename=\"Архив жалоб"+(params[:server_id] ? " (по оборудованию '"+Server.find(params[:server_id]).name+"')" : '')+(params[:type_id] ? " (по типу '"+Type.find(params[:type_id]).name+"')" : '')+(params[:priority_id] ? " (по приоритету '"+Priority.find(params[:priority_id]).name+"')" : '')+(params[:tag_id] ? " (по метке '"+Tag.find(params[:tag_id]).name+"')" : '')+(params[:user_id] ? " (по пользователю '"+User.find(params[:user_id]).realname+"')" : '')+".xls\""
      }
    end
  end

  # GET /incedents/observed
  # GET /incedents/observed.json
  def observe
    @incedents = get_incedents(false).by_user_as_observer(@current_user).paginate(page: params[:page], per_page: @per_page).order('finish_at')

    respond_to do |format|
      format.html # index.html.erb
      format.js
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
    end
  end

  # GET /incedents/new
  # GET /incedents/new.json
  def new
    @incedent = Incedent.new

    @incedent.initiator = @current_user
    @incedent.operator = @current_user
    @incedent.finish_at = Time.now + 1.days
    @incedent.status_id = Houston::Application.config.incedent_created

    @incedents = get_incedents(false).nested_set.all

    if params[:service_class_id]
      @incedent.service_class = ServiceClass.find(params[:service_class_id])
      @incedent.type_id = @incedent.service_class.type_id
      @incedent.priority_id = @incedent.service_class.priority_id
      @incedent.service_class_id = @incedent.service_class.id
      @incedent.finish_at = Time.now + @incedent.service_class.performance_hours.hours
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /incedents/1/edit
  def edit
    @incedent = Incedent.find(params[:id])

    @incedents = get_incedents(false).nested_set.all

    @attach = Attach.new
  end

  # POST /incedent/:id/comment
  def comment
    @incedent_comment = IncedentComment.new(incedent: Incedent.find(params[:incedent_comment][:incedent_id]), comment: Comment.new(params[:incedent_comment][:comment]))
    @incedent_comment.comment.author = @current_user

    respond_to do |format|
      @incedent_comment.comment.title = "Комментарий от пользователя "+@current_user.realname if @incedent_comment.comment.title.empty?

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
      else
        format.html { render action: 'new' }
      end
    end
  end

  # POST /incedent/add
  # POST /incedent/add.json
  def add
    @incedent = Incedent.new(params[:incedent].except(:attaches_attributes))

    respond_to do |format|
      @incedent.observer = nil if (@incedent.observer == @incedent.worker)

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
      else
        format.html { render action: 'new' }
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

        if !@incedent.is_solved?
          if (@incedent.worker)
            IncedentAction.create(incedent: @incedent, status: Status.find(Houston::Application.config.incedent_played), worker: @incedent.worker).save
          end

          IncedentMailer.incedent_changed(@incedent).deliver
        end

        format.html { redirect_to :incedents, notice: 'Жалоба успешно обновлена.' }
      else
        format.html { render action: 'edit' }
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
    end
  end

  # GET /incedent/1/watch
  # GET /incedent/1/watch.json
  def watch
    @incedent = Incedent.find(params[:id])

    if !@incedent.has_observer?

      @incedent.observer = @current_user

      respond_to do |format|
        if @incedent.save
          format.html { redirect_to :incedents_observe, notice: 'Наблюдатель успешно назначен.' }
        else
          format.html { render action: 'observe' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :incedents, alert: 'Наблюдатель уже назначен: '+@incedent.observer.realname }
      end
    end
  end

  # GET /incedent/1/unwatch
  # GET /incedent/1/unwatch.json
  def unwatch
    @incedent = Incedent.find(params[:id])

    if @incedent.has_observer?

      @incedent.observer = nil

      respond_to do |format|
        if @incedent.save
          format.html { redirect_to :incedents, notice: 'Наблюдатель успешно удален.' }
        else
          format.html { render action: 'observe' }
        end
      end
    end
  end

  # GET /incedent/1/play
  # GET /incedent/1/play.json
  def play
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user
    @incedent.played!

    @incedent.observer = nil if (@incedent.observer == @incedent.worker)

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_played(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно принята в работу.' }
      else
        format.html { render action: 'play' }
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

      @incedent.observer = nil if (@incedent.observer == @incedent.worker)

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба возобновлена', body: params[:incedent][:replay_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.worker).save

          IncedentMailer.incedent_replayed(@incedent).deliver

          format.html { redirect_to :incedents, notice: 'Жалоба успешно возобновлена.' }
        else
          format.html { render action: 'replay' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :incedents, alert: 'Нужно обязательно указать причину возобновления.' }
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

      @incedent.observer = nil if (@incedent.observer == @incedent.worker)

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба назначена исполнителю', body: params[:incedent][:work_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @incedent.worker).save

          IncedentMailer.incedent_worked(@incedent).deliver

          format.html { redirect_to :incedents, notice: 'Жалоба успешно передана в работу.' }
        else
          format.html { render action: 'work' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :incedents, alert: 'Нужно обязательно указать причину передачи.' }
      end
    end
  end

  # GET /incedent/1/pause
  # GET /incedent/1/pause.json
  def pause
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?
    @incedent.paused!

    @incedent.observer = nil if (@incedent.observer == @incedent.worker)

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_paused(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно приостановлена.' }
      else
        format.html { render action: 'pause' }
      end
    end
  end

  # GET /incedent/1/stop
  # GET /incedent/1/stop.json
  def stop
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?
    @incedent.stoped!

    @incedent.observer = nil if (@incedent.observer == @incedent.worker)

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_stoped(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно остановлена.' }
      else
        format.html { render action: 'stop' }
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

      @incedent.observer = nil if (@incedent.observer == @incedent.worker)

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба отклонена', body: params[:incedent][:reject_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

          IncedentMailer.incedent_rejected(@incedent).deliver

          format.html { redirect_to :incedents, notice: 'Жалоба успешно отклонена.' }
        else
          format.html { render action: 'reject' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :incedents, alert: 'Нужно обязательно указать причину отклонения.' }
      end
    end
  end

  # GET /incedent/1/solve
  # GET /incedent/1/solve.json
  def solve
    @incedent = Incedent.find(params[:id])

    @incedent.worker = @current_user unless @incedent.has_worker?
    @incedent.solved!

    @incedent.observer = nil if (@incedent.observer == @incedent.worker)

    respond_to do |format|
      if @incedent.save
        IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

        IncedentMailer.incedent_solved(@incedent).deliver

        format.html { redirect_to :incedents, notice: 'Жалоба успешно решена.' }
      else
        format.html { render action: 'solve' }
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

      @incedent.observer = nil if (@incedent.observer == @incedent.worker)

      IncedentComment.new(incedent: @incedent, comment: Comment.new(title: 'Жалоба закрыта', body: params[:incedent][:close_reason], author: @current_user)).save

      respond_to do |format|
        if @incedent.save
          IncedentAction.create(incedent: @incedent, status: @incedent.status, worker: @current_user).save

          IncedentMailer.incedent_closed(@incedent).deliver

          format.html { redirect_to :incedents, notice: 'Жалоба успешно закрыта.' }
        else
          format.html { render action: 'close' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :incedents, alert: 'Нужно обязательно указать причину закрытия.' }
      end
    end
  end

  protected

  def set_per_page
    if cookies[:viewmode] == 'table'
      @per_page = 20
    elsif cookies[:viewmode] == 'tree'
      @per_page = 20
    else
      @per_page = 5
    end
  end

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

end