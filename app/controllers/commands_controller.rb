# encoding: utf-8
class CommandsController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  # GET /commands/execute
  def execute
    @command = Command.find(params[:command][:id])
    @server = Server.find(params[:command][:server_id])
  end

  # GET /commands/run
  # GET /commands/run.json
  def run
    @command = Command.find(params[:id])

    if (params[:server_id]) 
      @server = Server.find(params[:server_id])
      if ServerCommand.command_for_server(@command, @server)
        @params = ServerCommand.command_for_server(@command, @server).params
      else
        @params = ""
      end
    else
      if ServerCommand.one_command(@command)
        @params = ServerCommand.one_command(@command).params
      else
        @params = ""
      end
    end

  end

  # GET /commands
  # GET /commands.json
  def index
    @commands = Command.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commands }
    end
  end

  # GET /commands/1
  # GET /commands/1.json
  def show
    @command = Command.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @command }
    end
  end

  # GET /commands/new
  # GET /commands/new.json
  def new
    @command = Command.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @command }
    end
  end

  # GET /commands/1/edit
  def edit
    @command = Command.find(params[:id])
  end

  # POST /commands
  # POST /commands.json
  def create
    @command = Command.new(params[:command])

    respond_to do |format|
      if @command.save
        format.html { redirect_to @command, notice: 'Команда успешно создана.' }
        format.json { render json: @command, status: :created, location: @command }
      else
        format.html { render action: "new" }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commands/1
  # PUT /commands/1.json
  def update
    @command = Command.find(params[:id])

    respond_to do |format|
      if @command.update_attributes(params[:command])
        format.html { redirect_to @command, notice: 'Команда успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commands/1
  # DELETE /commands/1.json
  def destroy
    @command = Command.find(params[:id])
    @command.destroy

    respond_to do |format|
      format.html { redirect_to commands_url }
      format.json { head :no_content }
    end
  end
end
