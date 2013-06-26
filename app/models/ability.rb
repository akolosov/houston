class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :manager
      can :update, User, id: user.id
      can :read, Server
      can :read, ServerProblem
      can :read, ServerCategory
      can :read, Problem
      can :read, Solution
      can :read, ProblemSolution
      can :read, Document
      can :read, Category
      can :read, Tag
      can :read, ProblemTag
      can :update, Document, user_id: user.id
      can :create, Document
      can :comment, Document
      can :create, Comment
      can :create, Comment
      can :create, DocumentComment
      can :create, IncedentComment
      can :add, Document
      can :add, Incedent
      can :create, Incedent
      can :play, Incedent
      can :read, Incedent
      can :create, Attach
      can :create, CommentAttach
      can :create, IncedentAttach
      can :create, DocumentAttach
      can :create, ServerAttach
      can :update, Incedent, initiator_id: user.id
      can :pause, Incedent, worker_id: user.id
      can :stop, Incedent, worker_id: user.id
      can :replay, Incedent, initiator_id: user.id
      can :replay, Incedent, worker_id: user.id
      can :reject, Incedent, worker_id: user.id
      can :close, Incedent, initiator_id: user.id
      can :close, Incedent, worker_id: user.id
      can :solve, Incedent, initiator_id: user.id
      can :archive, Incedent, initiator_id: user.id
      can :archive, Incedent, worker_id: user.id
      can :comment, Incedent, initiator_id: user.id
      can :comment, Incedent, worker_id: user.id
    elsif user.has_role? :user
      can :update, User, id: user.id
      can :read, Document
      can :update, Document, user_id: user.id
      can :add, Document
      can :add, Incedent
      can :create, Document
      can :create, Incedent
      can :create, Comment
      can :comment, Document
      can :create, DocumentComment
      can :create, IncedentComment
      can :create, Incedent
      can :create, Attach
      can :create, CommentAttach
      can :create, IncedentAttach
      can :create, DocumentAttach
      can :read, Incedent, initiator_id: user.id
      can :read, Incedent, worker_id: user.id
      can :update, Incedent, initiator_id: user.id
      can :play, Incedent, initiator_id: user.id
      can :play, Incedent, worker_id: user.id
      can :pause, Incedent, worker_id: user.id
      can :stop, Incedent, worker_id: user.id
      can :replay, Incedent, initiator_id: user.id
      can :replay, Incedent, worker_id: user.id
      can :reject, Incedent, worker_id: user.id
      can :close, Incedent, initiator_id: user.id
      can :close, Incedent, worker_id: user.id
      can :solve, Incedent, initiator_id: user.id
      can :archive, Incedent, initiator_id: user.id
      can :archive, Incedent, worker_id: user.id
      can :comment, Incedent, initiator_id: user.id
      can :comment, Incedent, worker_id: user.id
    end
  end
end


