# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, except: [:not_authenticated, :set_current_user, :prepare_for_mobile, :mobile_device?]

  before_filter :prepare_for_mobile, :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] =  "Недостаточно прав доступа!" #exception.message
    if !current_user
      redirect_to login_url
    else
      redirect_to root_url
    end
  end

  protected

  def not_authenticated
    redirect_to login_path, alert: "Для начала осуществите вход в ЦУП!"
  end

  private

  def set_current_user
    Auditor::User.current_user = @current_user
  end

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
