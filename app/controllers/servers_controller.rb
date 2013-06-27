# encoding: utf-8
class ServersController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /servers
  # GET /servers.json
  def index
    params[:category_id] ?
        @servers = Server.servers_by_category(Category.find(params[:category_id])).accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC') :
        @servers = Server.accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @servers }
    end
  end


  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end
  # GET /servers/new
  # GET /servers/new.json
  def new
    @server = Server.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(params[:server])

    respond_to do |format|
      if @server.save
        format.html { redirect_to :servers, notice: 'Оборудование успешно создано.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: 'new' }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /servers
  # POST /servers.json
  def add
    @server = Server.new(params[:server].except(:attaches_attributes))

    respond_to do |format|
      if @server.save

        if params[:server][:attaches_attributes]
          params[:server][:attaches_attributes].each do |key, attach|
            if attach[:file].present?
              save_server_attach(@server, attach)
              params[:server][:attaches_attributes].delete key
            end
          end
        end

        format.html { redirect_to :servers, notice: 'Оборудование успешно создано.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: 'new' }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    if params[:server][:attaches_attributes]
      params[:server][:attaches_attributes].each do |key, attach|
        if attach[:file].present?
          save_server_attach(@server, attach)
          params[:server][:attaches_attributes].delete key
        end
      end
    end

    respond_to do |format|
      if @server.update_attributes(params[:server])
        format.html { redirect_to :servers, notice: 'Оборудование успешно обновлено.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :no_content }
    end
  end

  protected

  def save_server_attach(server, attach)
    uploaded_io = attach[:file]

    Dir.mkdir(Rails.root.join('public', 'uploads', 'servers', server.id.to_s), 0777) unless Dir.exists?(Rails.root.join('public', 'uploads', 'servers', server.id.to_s))

    File.open(Rails.root.join('public', 'uploads', 'servers', server.id.to_s, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @attach = Attach.new(name: uploaded_io.original_filename, description: attach[:description], mime: uploaded_io.content_type, size: File.size(Rails.root.join('public', 'uploads', 'servers', server.id.to_s, uploaded_io.original_filename)))
    @attach.save

    @server_attach = ServerAttach.new(server: server, attach: @attach)
    @server_attach.save
  end
end
