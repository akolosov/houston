# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /users
  # GET /users.xml
  def index

    @users = User.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to :users, notice: 'Пользователь успешно создан.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :users, notice: 'Пользователь успешно обновлен.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :users, notice: 'Пользователь успешно удален.' }
    end
  end

  # GET /users/1/activate
  # GET /users/1/activate.xml
  def activate
    @user = User.find(params[:id])
    @user.activate!

    respond_to do |format|
      format.html { redirect_to :users, notice: 'Пользователь успешно активирован.' }
    end
  end

  # GET /users/1/deactivate
  # GET /users/1/deactivate.xml
  def deactivate
    @user = User.find(params[:id])
    @user.deactivate!

    respond_to do |format|
      format.html { redirect_to :users, notice: 'Пользователь успешно деактивирован.' }
    end
  end

end