module CanCan
  module ControllerAdditions

    def current_ability
      @current_ability ||= ::Ability.new(current_user, request.session_options[:id])
    end

  end
end

ActionController::Base.class_eval do
  include CanCan::ControllerAdditions
end

