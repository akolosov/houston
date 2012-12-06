# encoding: utf-8
class WelcomeController < ApplicationController
  skip_before_filter :require_login

  def index
  end

  def denied
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @post }
    end
  end

end
