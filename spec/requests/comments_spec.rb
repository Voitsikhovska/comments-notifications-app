require "rails_helper"

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:comment) { create(:comment, user: user) }

  describe "GET /comments" do
    context "when signed in" do
      before { sign_in user }

      it "returns http success" do
        get comments_path
        expect(response).to have_http_status(:ok)
      end
    end

    context "when signed out" do
      it "redirects to sign in" do
        get comments_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /comments" do
    before { sign_in user }

    context "with valid params" do
      it "creates a comment and redirects" do
        expect {
          post comments_path, params: { comment: { body: "Hello world!" } }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(comments_path)
      end
    end

    context "with invalid params" do
      it "does not create a comment and renders index" do
        expect {
          post comments_path, params: { comment: { body: "" } }
        }.not_to change(Comment, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /comments/:id/edit" do
    context "as the comment owner" do
      before { sign_in user }

      it "returns http success" do
        get edit_comment_path(comment)
        expect(response).to have_http_status(:ok)
      end
    end

    context "as another user" do
      before { sign_in other_user }

      it "redirects away" do
        get edit_comment_path(comment)
        expect(response).to redirect_to(comments_path)
      end
    end
  end

  describe "PATCH /comments/:id" do
    before { sign_in user }

    it "updates the comment" do
      patch comment_path(comment), params: { comment: { body: "Updated!" } }
      expect(comment.reload.body).to eq("Updated!")
      expect(response).to redirect_to(comments_path)
    end
  end

  describe "DELETE /comments/:id" do
    before { sign_in user }

    it "deletes the comment" do
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(comments_path)
    end

    context "as another user" do
      before { sign_in other_user }

      it "does not delete and redirects" do
        expect {
          delete comment_path(comment)
        }.not_to change(Comment, :count)
        expect(response).to redirect_to(comments_path)
      end
    end
  end
end

