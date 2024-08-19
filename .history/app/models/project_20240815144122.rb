class Project < ApplicationRecord
  validates :name, :description, presence: true
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs
end
