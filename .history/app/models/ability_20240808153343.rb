# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can [:read, :create], Project
      can [:destroy, :update], Project, id: user.projects.pluck(:id)
    end
  end
end
