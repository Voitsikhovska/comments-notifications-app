require "rails_helper"

RSpec.describe Notification, type: :model do
  subject(:notification) { build(:notification) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:actor).class_name("User") }
    it { is_expected.to belong_to(:comment) }
  end

  describe "scopes" do
    let(:user) { create(:user) }
    let(:actor) { create(:user) }
    let(:comment) { create(:comment, user: actor) }

    describe ".unread" do
      it "returns only unread notifications" do
        unread = create(:notification, user: user, actor: actor, comment: comment, read: false)
        create(:notification, user: user, actor: actor, comment: comment, read: true)

        expect(Notification.unread).to eq([ unread ])
      end
    end

    describe ".read" do
      it "returns only read notifications" do
        read = create(:notification, user: user, actor: actor, comment: comment, read: true)
        create(:notification, user: user, actor: actor, comment: comment, read: false)

        expect(Notification.read).to eq([ read ])
      end
    end
  end

  describe "#mark_as_read!" do
    it "marks the notification as read" do
      notification = create(:notification, read: false)
      notification.mark_as_read!

      expect(notification.reload.read).to be true
    end
  end

  describe "#unread?" do
    it "returns true when the notification has not been read" do
      notification = build(:notification, read: false)
      expect(notification.unread?).to be true
    end

    it "returns false when the notification has been read" do
      notification = build(:notification, read: true)
      expect(notification.unread?).to be false
    end
  end
end
