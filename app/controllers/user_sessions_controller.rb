# encoding: utf-8
class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if (@user = login(params[:email], params[:password], params[:remember]))
        if @user.active?
          success_login @user, format, 'Удачный вход!'
        else
          unable_to_login @user, format, 'Пользователь деактивирован!'
        end
      else
        unable_to_login @user, format, 'Неудачный вход!'
      end
    end
  end

  def success_login(user, format, message)
    format.html { redirect_back_or_to(root_path, notice: message) }
  end

  def unable_to_login(user, format, message)
    logout
    format.html { redirect_to(login_path, alert: message) }
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Удачный выход!')
  end

end
