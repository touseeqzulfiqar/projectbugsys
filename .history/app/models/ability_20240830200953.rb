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
    # Developers can read bugs that are either unassigned or assigned to them
    can :read, Bug, developer_id: [nil, user.id]
    cannot [:create, :destroy], Bug
  end
end

end
