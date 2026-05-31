class Comment < ApplicationRecord
  belongs_to :user

  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }

  after_create :notify_mentions

  private

  def notify_mentions
    MentionParser.call(self)
  end
end
