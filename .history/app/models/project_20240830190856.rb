class Project < ApplicationRecord
  validates :name, :description, presence: true
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy
  belong_to :creator, class_name: "User", foreign_key: "creator_id"
  accepts_nested_attributes_for :users, allow_destroy: true
end
