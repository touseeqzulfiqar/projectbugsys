class Project < ApplicationRecord
load_and_authorize_resource

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs
end
