# encoding: utf-8
class WelcomeController < ApplicationController
  skip_before_filter :require_login

  def index
    if !current_user
      redirect_to :login
    end
  end

  def denied
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
