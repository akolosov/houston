module CanCan
  module ControllerAdditions

    def current_ability
      @current_ability ||= ::Ability.new(current_user)
    end

  end
end

ActionController::Base.class_eval do
  include CanCan::ControllerAdditions
end

