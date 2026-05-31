class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authorize_comment!, only: [:edit, :update, :destroy]

  def index
    load_comments
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_to comments_path, notice: "Comment posted."
    else
      load_comments
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to comments_path, notice: "Comment updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_path, notice: "Comment deleted."
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def load_comments
    @comments = Comment.includes(:user).recent
  end

  def authorize_comment!
    return if @comment.user == current_user

    redirect_to comments_path, alert: "Not authorized."
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
