class SearchController < ApplicationController

  def index
  	if params[:query]
      if (@current_user.has_role? :admin)
  		  @commands = Command.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
      end

      @servers = Server.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
  		@problems = Problem.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")
  		@solutions = Solution.where("name like '%#{params[:query]}%' or description like '%#{params[:query]}%'")

  	  respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @problems }
	    end
  	end
  end

end
