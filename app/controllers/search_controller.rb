class SearchController < ApplicationController

  def index
    if params[:query]
      @documents = Document.search(params[:query]) if Document.methods.include? :search
      @incedents = Incedent.accessible_by(current_ability).search(params[:query]) if Incedent.methods.include? :search
      @services = Service.accessible_by(current_ability).search(params[:query]) if Service.methods.include? :search

      if current_user.has_role? :manager or current_user.has_role? :admin
        @servers = Server.search(params[:query]) if Server.methods.include? :search
        @problems = Problem.search(params[:query]) if Problem.methods.include? :search
        @solutions = Solution.search(params[:query]) if Solution.methods.include? :search
      end

      if current_user.has_role? :admin
          @attaches = Attach.search(params[:query]) if Attach.methods.include? :search
          @audits = Audit.search(params[:query]).order('created_at DESC') if Audit.methods.include? :search
      end

      respond_to do |format|
        format.html
      end
    end
  end

end
