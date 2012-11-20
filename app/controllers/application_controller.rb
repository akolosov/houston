# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_for_mobile

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] =  "Недостаточно прав доступа!" #exception.message
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

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
end
