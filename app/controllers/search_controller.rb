class SearchController < ApplicationController

  def index
  	if params[:query]
      @servers = Server.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
  		@problems = Problem.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
  		@solutions = Solution.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
      @documents = Document.where("title like '%#{params[:query]}%' or body like '%#{params[:query]}%'")

      if current_user.has_role? :admin
        @audits = Audit.where("audited_changes like '%#{params[:query]}%' or comment like '%#{params[:query]}%'").order('created_at DESC')
      end

  	  respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @problems }
	    end
  	end
  end

end
