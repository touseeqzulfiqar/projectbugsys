class Bug < ApplicationRecord

  enum status: {Open: "open",InProgress: "in_progress", Resolved: "resolved", Closed: "closed"}
  enum bug_type: {Feature: "feature", Bugfix: "bugfix",Enhancement: "enhancement"}
  belongs_to :project
  belongs_to :user
  has_one_attached :screenshot
end
