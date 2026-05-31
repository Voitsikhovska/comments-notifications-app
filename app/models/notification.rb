class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User"
  belongs_to :comment

  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }

  def mark_as_read!
    update!(read: true)
  end

  def unread?
    !read?
  end
end
