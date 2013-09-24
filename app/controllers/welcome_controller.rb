# encoding: utf-8
class WelcomeController < ApplicationController
  include ApplicationHelper

  skip_before_filter :require_login

  def index
    if !current_user
      redirect_to :login
    else
      @divisions = Division.accessible_by(current_ability).all
      @incedents = get_incedents(false).nested_set.paginate(page: params[:page], per_page: 20).order('finish_at')

      respond_to do |format|
        format.html # index.html.erb
        format.js
      end
    end
  end

end
