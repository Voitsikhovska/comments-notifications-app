class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only letters, numbers, and underscores" }

  validate :password_complexity

  private

  def password_complexity
    return if password.blank?

    errors.add(:password, "must contain at least one uppercase letter") unless password.match?(/[A-Z]/)
    errors.add(:password, "must contain at least one number") unless password.match?(/[0-9]/)
    errors.add(:password, "must contain at least one special character") unless password.match?(/[^a-zA-Z0-9]/)
  end
end
