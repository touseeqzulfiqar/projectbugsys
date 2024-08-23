class Bug < ApplicationRecord

  enum status: {New: "new", Started: "started", Resolved: "resolved", Completed: "completed"}
  enum bug_type: {Feature: "feature", Bugfix: "bug"}
  belongs_to :project
  belongs_to :user
  has_one_attached :screenshot
end
