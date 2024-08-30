# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can [:read, :create], Project
      can [:destroy, :update], Project, id: user.projects.pluck(:id)
      can [:destroy, :update, :create, :read], Bug
    elsif user.QA?
      can :read, Project
      can [:read, :create], Bug
      can [:destroy, :update], Bug, id: user.bugs.pluck(:id)
    elsif user.developer?
      can :read, Project, id: user.projects.pluck(:id)
      can :read, Bug, developer_id: [nil, user.id]
      # can :read, Bug, id: user.bugs.pluck(:id)
      cannot [:create, :destroy], Bug
    end

  end
end
