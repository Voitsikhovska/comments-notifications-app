class NotificationsController < ApplicationController
  before_action :set_notification, only: [ :update ]

  def index
    @notifications = current_user.notifications.includes(:actor, :comment).recent.to_a
    @unread_count = @notifications.count { |n| !n.read? }
  end

  def update
    @notification.mark_as_read!
    redirect_to notifications_path
  end

  def mark_all_read
    current_user.notifications.unread.update_all(read: true)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end
