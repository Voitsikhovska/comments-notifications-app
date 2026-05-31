require "rails_helper"

RSpec.describe MentionParser do
  let!(:alice) { create(:user, username: "alice") }
  let!(:bob)   { create(:user, username: "bob") }

  describe ".call" do
    context "when a user is mentioned" do
      it "creates a notification for the mentioned user" do
        comment = create(:comment, user: alice, body: "Hey @bob check this out!")

        expect(Notification.count).to eq(1)
        notification = Notification.last
        expect(notification.user).to eq(bob)
        expect(notification.actor).to eq(alice)
        expect(notification.comment).to eq(comment)
        expect(notification.read).to be false
      end
    end

    context "when multiple users are mentioned" do
      it "creates a notification for each mentioned user" do
        charlie = create(:user, username: "charlie")
        create(:comment, user: alice, body: "Hey @bob and @charlie!")

        expect(Notification.count).to eq(2)
        expect(Notification.pluck(:user_id)).to match_array([ bob.id, charlie.id ])
      end
    end

    context "when the same user is mentioned twice" do
      it "creates only one notification" do
        create(:comment, user: alice, body: "@bob @bob duplicate!")

        expect(Notification.count).to eq(1)
      end
    end

    context "when the author mentions themselves" do
      it "does not create a notification" do
        create(:comment, user: alice, body: "I am @alice and I said something")

        expect(Notification.count).to eq(0)
      end
    end

    context "when a non-existent username is mentioned" do
      it "does not create a notification" do
        create(:comment, user: alice, body: "Hey @nobody_here!")

        expect(Notification.count).to eq(0)
      end
    end

    context "when there are no mentions" do
      it "does not create any notifications" do
        create(:comment, user: alice, body: "Just a regular comment")

        expect(Notification.count).to eq(0)
      end
    end
  end
end
