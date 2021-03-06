# encoding: utf-8
class DocumentsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    @document_comment = DocumentComment.new
    @document_comment.comment = Comment.new
    @document_comment.comment.author = @current_user
    @document_comment.document = @document

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new
    @document.user = current_user

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /document/:id/comment
  def comment
    @document_comment = DocumentComment.new(document: Document.find(params[:document_comment][:document_id]), comment: Comment.new(params[:document_comment][:comment]))
    @document_comment.comment.author = @current_user

    respond_to do |format|
      @document_comment.comment.title = "Комментарий от пользователя "+@current_user.realname if @document_comment.comment.title.empty?

      if @document_comment.save

        if params[:document_comment][:comment][:attaches_attributes]
          params[:document_comment][:comment][:attaches_attributes].each do |key, attach|
            if attach[:file].present?
              save_comment_attach(@document_comment.comment, attach)
            end
          end
        end

        format.html { redirect_to @document_comment.document, notice: 'Коментарий успешно добавлен.' }
      else
        format.html { render action: 'show' }
      end
    end
  end

  # POST /document/:document_id/comment/:comment_id/delete
  def delete_comment
    @comment = Comment.find(params[:comment_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to document_comments_path(Document.find(params[:document_id])), notice: 'Коментарий успешно удален.' }
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Рецепт успешно создан.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # POST /document/add
  # POST /document/add.json
  def add
    @document = Document.new(params[:document].except(:attaches_attributes))

    respond_to do |format|
      if @document.save

        if params[:document][:attaches_attributes]
          params[:document][:attaches_attributes].each do |key, attach|
            if attach[:file].present?
              save_document_attach(@document, attach)
            end
          end
        end

        format.html { redirect_to @document, notice: 'Рецепт успешно создан.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    if params[:document][:attaches_attributes]
      params[:document][:attaches_attributes].each do |key, attach|
        if attach[:file].present?
          save_document_attach(@document, attach)
          params[:document][:attaches_attributes].delete key
        end
      end
    end

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Рецепт успешно обновлен.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to :documents, notice: 'Рецепт успешно удален.' }
    end
  end

  # PUT /documents/1/move
  # PUT /documents/1/move.json
  def move
    @document = Document.find(params[:id])
    @solution = Solution.create(name: @document.title, description: @document.body)

    respond_to do |format|
      if @solution.save
        @document.destroy
        format.html { redirect_to solutions_path, notice: 'Рецепт успешно перенесен в решения.' }
      else
        format.html { render action: 'move' }
      end
    end
  end

  protected

  def save_document_attach(document, attach)
    uploaded_io = attach[:file]

    Dir.mkdir(Rails.root.join('public', 'uploads', 'documents', document.id.to_s), 0777) unless Dir.exists?(Rails.root.join('public', 'uploads', 'documents', document.id.to_s))

    File.open(Rails.root.join('public', 'uploads', 'documents', document.id.to_s, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @attach = Attach.new(name: uploaded_io.original_filename, description: attach[:description], mime: uploaded_io.content_type, size: File.size(Rails.root.join('public', 'uploads', 'documents', document.id.to_s, uploaded_io.original_filename)))
    @attach.save

    @document_attach = DocumentAttach.new(document: document, attach: @attach)
    @document_attach.save
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
