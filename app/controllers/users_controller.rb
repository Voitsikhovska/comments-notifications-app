class UsersController < ApplicationController
  def search
    query = params[:q].to_s.strip
    users = User.where("username ILIKE ?", "#{query}%")
                .where.not(id: current_user.id)
                .order(:username)
                .limit(5)
                .pluck(:username)

    render json: users
  end
end
