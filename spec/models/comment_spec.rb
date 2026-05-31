require "rails_helper"

RSpec.describe Comment, type: :model do
  subject(:comment) { build(:comment) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(1000) }
  end

  describe "scopes" do
    describe ".recent" do
      it "orders comments by created_at descending" do
        user = create(:user)
        old_comment = create(:comment, user: user, created_at: 2.days.ago)
        new_comment = create(:comment, user: user, created_at: 1.day.ago)

        expect(Comment.recent).to eq([ new_comment, old_comment ])
      end
    end
  end
end

