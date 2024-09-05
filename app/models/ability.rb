# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can %i[read create], Project
      can %i[destroy update], Project, creator_id: user.id
      can %i[destroy update create read], Bug

    elsif user.QA?
      can :read, Project
      can %i[read create], Bug
      can %i[destroy update], Bug, id: user.bugs.pluck(:id)

    elsif user.developer?
      can :read, Project, id: user.projects.pluck(:id)
      # Developers can read bugs that are either unassigned or assigned to them
      can %i[read update], Bug, developer_id: [nil, user.id]
      cannot %i[create destroy], Bug
    end
  end
end
