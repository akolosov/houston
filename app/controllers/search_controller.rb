class SearchController < ApplicationController

  def index
  	if params[:query]
      @documents = Document.where("title like '%#{params[:query]}%' or body like '%#{params[:query]}%'")
      @incedents = Incedent.accessible_by(current_ability).where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")

      if current_user.has_role? :manager or current_user.has_role? :admin
        @servers = Server.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
        @problems = Problem.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
        @solutions = Solution.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
      end

      if current_user.has_role? :admin
        @audits = Audit.where("audited_changes like '%#{params[:query]}%' or comment like '%#{params[:query]}%'").order('created_at DESC')
      end

  	  respond_to do |format|
	      format.html # index.html.erb
	    end
  	end
  end

end
