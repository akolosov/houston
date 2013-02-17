# encoding: utf-8
class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if (@user = login(params[:email], params[:password], params[:remember]))
        format.html { redirect_back_or_to(root_path, notice: 'Удачный вход!') }
        format.json { render json: @user, status: :created, location: @user }
        format.xml  { render xml: @user, status: :created, location: @user }
      else
        format.html { flash.now[:alert] = 'Неудачный вход!'
        ; render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml  { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Удачный выход!')
  end

end
