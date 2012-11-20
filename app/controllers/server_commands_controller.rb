# encoding: utf-8
class ServerCommandsController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  # GET /server_commands/run
  # GET /server_commands/run.json
  def run
    @server_command = ServerCommand.find(params[:id])
  end

  # GET /server_commands
  # GET /server_commands.json
  def index
    if (params[:server_id]) 
      @server_commands = ServerCommand.find_all_by_server_id(params[:server_id])
    else
      @server_commands = ServerCommand.accessible_by(current_ability)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @server_commands }
    end
  end

  # GET /server_commands/1
  # GET /server_commands/1.json
  def show
    @server_command = ServerCommand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server_command }
    end
  end

  # GET /server_commands/new
  # GET /server_commands/new.json
  def new
    @server_command = ServerCommand.new

    if (params[:server_id]) 
      @server_command.server = Server.find(params[:server_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server_command }
    end
  end

  # GET /server_commands/1/edit
  def edit
    @server_command = ServerCommand.find(params[:id])
  end

  # POST /server_commands
  # POST /server_commands.json
  def create
    @server_command = ServerCommand.new(params[:server_command])

    respond_to do |format|
      if @server_command.save
        format.html { redirect_to (@server_command.server ? commands_by_server_path(@server_command.server) : @server_command), notice: 'Команда для сервера успешно создана.' }
        format.json { render json: @server_command, status: :created, location: @server_command }
      else
        format.html { render action: "new" }
        format.json { render json: @server_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /server_commands/1
  # PUT /server_commands/1.json
  def update
    @server_command = ServerCommand.find(params[:id])

    respond_to do |format|
      if @server_command.update_attributes(params[:server_command])
        format.html { redirect_to (@server_command.server ? commands_by_server_path(@server_command.server) : @server_command), notice: 'Команда для сервера успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_commands/1
  # DELETE /server_commands/1.json
  def destroy
    @server_command = ServerCommand.find(params[:id])
    @server_command.destroy

    respond_to do |format|
      format.html { redirect_to server_commands_url }
      format.json { head :no_content }
    end
  end
end
