class Project < ApplicationRecord
  validates :name, :description, presence: true
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs
  accepts_nested_attributes_for :users, allow_destroy: true
end

class User < ApplicationRecord
  has_many :user_projects
  has_many :projects, through: :user_projects
end

class UserProject < ApplicationRecord
  belongs_to :project
  belongs_to :user
end
