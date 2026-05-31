class UsersController < ApplicationController
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
