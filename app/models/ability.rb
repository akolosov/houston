class Ability
  include CanCan::Ability

  def initialize(user, session)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :manager
      can :update, User, id: user.id
      can :read, Server
      can :read, ServerProblem
      can :read, Problem
      can :read, Solution
      can :read, ProblemSolution
      can :read, Document
      can :read, Tag
      can :read, ProblemTag
      can :update, Document, user_id: user.id
      can :create, Document
      can :create, Comment
      can :create, Comment
      can :create, DocumentComment
      can :create, IncedentComment
      can :create, Incedent
      can :play, Incedent
      can :read, Incedent, closed: false
      can :update, Incedent, initiator_id: user.id, closed: false
      can :pause, Incedent, worker_id: user.id, closed: false
      can :stop, Incedent, worker_id: user.id, closed: false
      can :replay, Incedent, initiator_id: user.id, closed: false
      can :replay, Incedent, worker_id: user.id, closed: false
      can :reject, Incedent, worker_id: user.id, closed: false
      can :close, Incedent, initiator_id: user.id, closed: false
      can :close, Incedent, worker_id: user.id, closed: false
      can :solve, Incedent, initiator_id: user.id, closed: false
    elsif user.has_role? :user
      can :update, User, id: user.id
      can :read, Document
      can :update, Document, user_id: user.id
      can :create, Document
      can :create, Comment
      can :create, DocumentComment
      can :create, IncedentComment
      can :create, Incedent
      can :read, Incedent, initiator_id: user.id, closed: false
      can :read, Incedent, worker_id: user.id, closed: false
      can :update, Incedent, initiator_id: user.id, closed: false
      can :play, Incedent, initiator_id: user.id, closed: false
      can :play, Incedent, worker_id: user.id, closed: false
      can :pause, Incedent, worker_id: user.id, closed: false
      can :stop, Incedent, worker_id: user.id, closed: false
      can :replay, Incedent, initiator_id: user.id, closed: false
      can :replay, Incedent, worker_id: user.id, closed: false
      can :reject, Incedent, worker_id: user.id, closed: false
      can :close, Incedent, initiator_id: user.id, closed: false
      can :close, Incedent, worker_id: user.id, closed: false
      can :solve, Incedent, initiator_id: user.id, closed: false
    end

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end


