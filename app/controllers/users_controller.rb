# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /users
  # GET /users.xml
  def index
    if params[:division_id]
      @users = User.by_division(params[:division_id]).accessible_by(current_ability)
    else
      @users = User.accessible_by(current_ability)
    end

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

  # GET /users/1/settings
  def setup
    @user = User.find(params[:id])
  end

  # GET /users/first_login
  def first_login
  end

  # GET /users/1/reset
  def reset
    @user = User.find(params[:id])

    @user.password = '123456'
    @user.first_login = true

    @user.config.table_count = 20
    @user.config.tree_count = 20
    @user.config.list_count = 5
    @user.config.refresh_interval = 180
    @user.config.time_zone = Houston::Application.config.time_zone

    respond_to do |format|
      if @user.save
        UserMailer.user_reseted(@user).deliver

        format.html { redirect_to :users, notice: 'Настройки пользователя успешно сброшены.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    @user.password = '123456'
    @user.add_role :user

    respond_to do |format|
      if @user.save
        UserMailer.user_created(@user).deliver

        format.html { redirect_to :users, notice: 'Пользователь успешно создан.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /users/1/password
  def update_password
    @user = User.find(params[:id])

    respond_to do |format|
      if (!params[:password].empty?) and (params[:password] == params[:password_confirmation])
        @user.password = params[:password]
        @user.first_login_success!

        format.html { redirect_to :root, notice: 'Пароль успешно обновлен.' }
      else
        format.html { redirect_to :first_login, alert: 'Возможно пароли не совпадают! Попробуйте снова!' }
      end
    end
  end

  # PUT /users/1/settings
  def user_settings
    @user = User.find(params[:id])

    respond_to do |format|
      params[:user][:config].each do |name, value|
        @user.config[name] = value
      end

      if @user.save
        format.html { redirect_to :root, notice: 'Настройки пользователя успешно обновлены.' }
      else
        format.html { redirect_to :user_settings, alert: 'Неверные параметры настройки! Попробуйте снова!' }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to ((@current_user.has_role? :admin) ? :users : :root), notice: 'Пользователь успешно обновлен.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    UserMailer.user_deleted(@user).deliver

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

    UserMailer.user_activated(@user).deliver

    respond_to do |format|
      format.html { redirect_to :users, notice: 'Пользователь успешно активирован.' }
    end
  end

  # GET /users/1/deactivate
  # GET /users/1/deactivate.xml
  def deactivate
    @user = User.find(params[:id])
    @user.deactivate!

    UserMailer.user_deactivated(@user).deliver

    respond_to do |format|
      format.html { redirect_to :users, notice: 'Пользователь успешно деактивирован.' }
    end
  end

end