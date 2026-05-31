class Comment < ApplicationRecord
  include MeiliSearch::Rails

  belongs_to :user

  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }

  after_create :notify_mentions

  meilisearch do
    attribute :body
    attribute :username do
      user&.username
    end
    searchable_attributes [ :body, :username ]
  end

  # Avoid N+1 queries during Meilisearch reindexing
  # since :username depends on the associated user
  def self.meilisearch_import
    includes(:user)
  end

  private

  def notify_mentions
    MentionParser.call(self)
  end
end
