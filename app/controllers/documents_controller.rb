# encoding: utf-8
class DocumentsController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.accessible_by(current_ability).paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new
    @document.user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Рецепт удачно создан.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Рецепт удачно обновлен.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  # PUT /documents/1/move
  # PUT /documents/1/move.json
  def move
    @document = Document.find(params[:id])
    @solution = Solution.create(:name => @document.title, :description => @document.body)

    respond_to do |format|
      if @solution.save
        @document.destroy
        format.html { redirect_to solutions_path, notice: 'Рецепт удачно перенесен в решения.' }
        format.json { head :no_content }
      else
        format.html { render action: "move" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

end
