# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] =  "Недостаточно прав доступа! Попробуйте авторизоваться!" #exception.message
    if !current_user
      redirect_to login_url
    else
      redirect_to root_url
    end
  end

  before_filter :require_login, :except => [:not_authenticated]

  helper_method :current_users_list

  protected

  def not_authenticated
    redirect_to login_path, :alert => "Для начала осуществите вход в ЦУП!"
  end

end
