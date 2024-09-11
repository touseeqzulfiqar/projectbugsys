class Ability
  include CanCan::Ability

  def initialize(user)
    # Manager Role
    if user.manager?
      # Manager can create, edit, and delete projects they create
      can :create, Project
      can :read, Project
      can %i[update destroy], Project, creator_id: user.id

      # Manager can add/remove developers and QA to/from projects they create
      can :manage_members, Project, creator_id: user.id

      # Manager can perform all actions on bugs in their own projects
      can %i[read create update destroy], Bug, project: { creator_id: user.id }

    # QA Role
    elsif user.QA?
      # QA can read all projects
      can :read, Project

      # QA can report (create) bugs for all projects
      can :create, Bug
      can :destroy, Bug
      can :update, Bug
      # QA can read bugs but cannot update or delete them
      can :read, Bug

      # QA cannot edit/delete/create projects
      cannot %i[update create], Project
      cannot :destroy, Project

    # Developer Role
    elsif user.developer?
      # Developer can only see projects they are part of
      can :read, Project, id: user.projects.pluck(:id)

      # Developer can assign a bug to themselves (pick up a bug from the list of their projects)
      can :assign, Bug, project: { id: user.projects.pluck(:id) }, developer_id: nil

      # Developer can mark a bug as resolved for their assigned bugs
      can :update, Bug

      # Developer can only see and update bugs assigned to them
      can :read, Bug, project: { id: user.projects.pluck(:id) }
      can :update, Bug, developer_id: user.id

      # Developer cannot report bugs
      cannot :create, Bug

      # Developer cannot delete bugs
      cannot :destroy, Bug

      # Developer cannot join projects (managed by manager)
      cannot :join, Project
    end
  end
end
