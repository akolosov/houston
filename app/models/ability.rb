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
      can :play, Incedent
      can :read, Incedent
      can :create, Attach
      can :create, CommentAttach
      can :create, IncedentAttach
      can :create, DocumentAttach
      can :create, ServerAttach
      can :update, Incedent, operator_id: user.id
      can [:comment, :archive, :solve, :close, :update, :replay], Incedent, initiator_id: user.id
      can [:reject, :replay, :pause, :stop, :archive, :comment, :close], Incedent, incedent_workers: { id: user.worked_incedent_ids }
      can [:review, :onreview, :comment, :reject], Incedent, incedent_reviewers: { id: user.reviewed_incedent_ids }
      can [:unwatch, :observe, :comment, :archive], Incedent, incedent_observers: { id: user.observed_incedent_ids }
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
      can [:comment, :archive, :solve, :close, :replay, :update], Incedent, initiator_id: user.id
      can [:comment, :archive, :close, :reject, :replay, :stop, :pause], Incedent, incedent_workers: { id: user.worked_incedent_ids }
      can [:comment, :archive], Incedent, incedent_observers: { id: user.observed_incedent_ids }
      can [:review, :onreview, :comment, :reject], Incedent, incedent_reviewers: { id: user.reviewed_incedent_ids }
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
      can [:update, :read], Incedent, operator_id: user.id
      can [:comment, :archive, :solve, :close, :replay, :play, :update, :read], Incedent, initiator_id: user.id
      can [:comment, :archive, :close, :reject, :replay, :stop, :pause, :play, :read], Incedent, incedent_workers: { id: user.worked_incedent_ids }
      can [:comment, :archive, :read], Incedent, incedent_observers: { id: user.observed_incedent_ids }
      can [:review, :onreview, :reject, :comment], Incedent, incedent_reviewers: { id: user.reviewed_incedent_ids }
    end
  end
end


