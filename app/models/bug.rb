class Bug < ApplicationRecord
  enum status: { New: 'new', started: 'started', resolved: 'resolved', completed: 'completed' }
  enum bug_type: { feature: 'feature', bug: 'bug' }

  validates :title, presence: true, uniqueness: { scope: :project_id, message: 'must be unique within the project' }
  validates :status, :bug_type, presence: true
  belongs_to :project
  belongs_to :user
  belongs_to :developer, class_name: 'User', optional: true

  has_one_attached :screenshot

  validate :correct_screenshot_mime_type

  private

  def correct_screenshot_mime_type
    return unless screenshot.attached? && !screenshot.content_type.in?(%w[image/png image/gif])

    errors.add(:screenshot, 'must be a PNG or GIF file')
  end
end
