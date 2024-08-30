class Bug < ApplicationRecord
   validates :description, presence: true, uniqueness: { scope: :project_id, message: "must be unique within the project" }
  validates :status, :bug_type, presence: true
  enum status: {New: "new", Started: "started", Resolved: "resolved", Completed: "completed"}
  enum bug_type: {Feature: "feature", Bug: "bug"}
  belongs_to :project
  belongs_to :user
  belongs_to :developer, class_name: 'User', optional: true 
  has_one_attached :screenshot
end
