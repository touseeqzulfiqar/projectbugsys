class Bug < ApplicationRecord

  enum status: {Open: "open",InProgress: "in_progress", Resolved: "resolved", Closed: "closed"}
  enum bug_type: {Feature: "feature", bug: 1, enhancement: 2}
  belongs_to :project
  belongs_to :user
end
