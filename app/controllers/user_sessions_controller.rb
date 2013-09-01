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
    if user.first_login?
      format.html { redirect_back_or_to :first_login, notice: 'Первый вход в систему. Задайте новый пароль!' }
    else
      format.html { redirect_back_or_to :root, notice: message }
    end
  end

  def unable_to_login(user, format, message)
    logout
    format.html { redirect_to :login, alert: message }
  end

  def destroy
    logout
    redirect_to :root, notice: 'Удачный выход!'
  end

end
