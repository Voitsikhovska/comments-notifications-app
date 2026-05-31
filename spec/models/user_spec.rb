require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "username format" do
    it "is valid with letters, numbers and underscores" do
      user = build(:user, username: "john_doe123")
      expect(user).to be_valid
    end

    it "is invalid with special characters" do
      user = build(:user, username: "john doe!")
      expect(user).not_to be_valid
    end
  end

  describe "password complexity" do
    it "is invalid without an uppercase letter" do
      user = build(:user, password: "password1!", password_confirmation: "password1!")
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("must contain at least one uppercase letter")
    end

    it "is invalid without a number" do
      user = build(:user, password: "Password!", password_confirmation: "Password!")
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("must contain at least one number")
    end

    it "is invalid without a special character" do
      user = build(:user, password: "Password1", password_confirmation: "Password1")
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("must contain at least one special character")
    end

    it "is valid with uppercase, number and special character" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
