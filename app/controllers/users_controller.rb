class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params[:username])
    @comments = @user.comments.recent
  end

  def search
    query = params[:q].to_s.strip
    safe_query = User.sanitize_sql_like(query)
    users = User.where("username ILIKE ?", "#{safe_query}%")
                .where.not(id: current_user.id)
                .order(:username)
                .limit(5)
                .pluck(:username)

    render json: users
  end
end
