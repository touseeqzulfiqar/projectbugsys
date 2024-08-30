class Bug < ApplicationRecord
  validates :status,:bug_type, presence: true
  enum status: {New: "new", Started: "started", Resolved: "resolved", Completed: "completed"}
  enum bug_type: {Feature: "feature", Bug: "bug"}
  belongs_to :project
  belongs_to :user
  has_one_attached :screenshot
end
