class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    permissions_for user, as: :admin do
      can :manage, :all
    end

    permissions_for user, as: :manager do
      can :first_login, User
      can :update_password, User, id: user.id
      can :update, User, id: user.id
      can :read, Division
      can :read, Service
      can :read, ServiceClass
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
      can :watch, Incedent
      can :unwatch, Incedent, observer_id: user.id
      can :play, Incedent
      can :read, Incedent
      can :create, Attach
      can :create, CommentAttach
      can :create, IncedentAttach
      can :create, DocumentAttach
      can :create, ServerAttach
      can :update, Incedent, operator_id: user.id
      can :update, Incedent, initiator_id: user.id
      can :pause, Incedent, worker_id: user.id
      can :stop, Incedent, worker_id: user.id
      can :replay, Incedent, initiator_id: user.id
      can :replay, Incedent, worker_id: user.id
      can :reject, Incedent, worker_id: user.id
      can :reject, Incedent, reviewer_id: user.id, reviewed_at: nil
      can :close, Incedent, initiator_id: user.id
      can :close, Incedent, worker_id: user.id
      can :solve, Incedent, initiator_id: user.id
      can :archive, Incedent, initiator_id: user.id
      can :archive, Incedent, worker_id: user.id
      can :archive, Incedent, observer_id: user.id
      can :comment, Incedent, initiator_id: user.id
      can :comment, Incedent, worker_id: user.id
      can :comment, Incedent, observer_id: user.id
      can :comment, Incedent, reviewer_id: user.id
      can :observe, Incedent, observer_id: user.id
      can :onreview, Incedent, reviewer_id: user.id, reviewed_at: nil
      can :review, Incedent, reviewer_id: user.id, reviewed_at: nil
    end

    permissions_for user, as: :executor do
      can :first_login, User
      can :update_password, User, id: user.id
      can :update, User, id: user.id
      can :read, Division
      can :read, Service
      can :read, ServiceClass
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
      can :update, Incedent, operator_id: user.id
      can :update, Incedent, initiator_id: user.id
      can :pause, Incedent, worker_id: user.id
      can :stop, Incedent, worker_id: user.id
      can :replay, Incedent, initiator_id: user.id
      can :replay, Incedent, worker_id: user.id
      can :reject, Incedent, worker_id: user.id
      can :reject, Incedent, reviewer_id: user.id, reviewed_at: nil
      can :close, Incedent, initiator_id: user.id
      can :close, Incedent, worker_id: user.id
      can :solve, Incedent, initiator_id: user.id
      can :archive, Incedent, initiator_id: user.id
      can :archive, Incedent, worker_id: user.id
      can :archive, Incedent, observer_id: user.id
      can :comment, Incedent, initiator_id: user.id
      can :comment, Incedent, worker_id: user.id
      can :comment, Incedent, observer_id: user.id
      can :comment, Incedent, reviewer_id: user.id
      can :onreview, Incedent, reviewer_id: user.id, reviewed_at: nil
      can :review, Incedent, reviewer_id: user.id, reviewed_at: nil
    end

    permissions_for user, as: [:operator, :client] do
      can :first_login, User
      can :update_password, User, id: user.id
      can :update, User, id: user.id
      can :read, Division
      can :read, Service
      can :read, ServiceClass
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
      can :read, Incedent, observer_id: user.id
      can :read, Incedent, operator_id: user.id
      can :update, Incedent, operator_id: user.id
      can :update, Incedent, initiator_id: user.id
      can :play, Incedent, initiator_id: user.id
      can :play, Incedent, worker_id: user.id
      can :pause, Incedent, worker_id: user.id
      can :stop, Incedent, worker_id: user.id
      can :replay, Incedent, initiator_id: user.id
      can :replay, Incedent, worker_id: user.id
      can :reject, Incedent, worker_id: user.id
      can :reject, Incedent, reviewer_id: user.id, reviewed_at: nil
      can :close, Incedent, initiator_id: user.id
      can :close, Incedent, worker_id: user.id
      can :solve, Incedent, initiator_id: user.id
      can :archive, Incedent, initiator_id: user.id
      can :archive, Incedent, worker_id: user.id
      can :archive, Incedent, observer_id: user.id
      can :comment, Incedent, initiator_id: user.id
      can :comment, Incedent, worker_id: user.id
      can :comment, Incedent, observer_id: user.id
      can :comment, Incedent, reviewer_id: user.id
      can :onreview, Incedent, reviewer_id: user.id, reviewed_at: nil
      can :review, Incedent, reviewer_id: user.id, reviewed_at: nil
    end
  end
end


