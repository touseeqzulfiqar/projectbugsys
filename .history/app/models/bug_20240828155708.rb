class Bug < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :project_id, message: 'must be unique within the project' }
  validates :status, :bug_type, presence: true
  enum status: { New: 'new', Started: 'started', Resolved: 'resolved', Completed: 'completed' }
  enum bug_type: { Feature: 'feature', Bug: 'bug' }
  belongs_to :project
  belongs_to :user
  belongs_to :developer, class_name: 'User', optional: true
  has_one_attached :screenshot
  validate :correct_screenshot_mime_type
  def correct_screenshot_mime_type
    return unless screenshot.attached? && !screenshot.content_type.in?(%w[image/png image/gif])

    errors.add(:screenshot, 'must be a PNG or GIF file')
  end
end
