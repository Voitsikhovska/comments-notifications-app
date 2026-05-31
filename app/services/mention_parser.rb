class MentionParser
  USERNAME_MENTION_REGEX = /@([a-zA-Z0-9_]+)/

  def self.call(comment)
    new(comment).call
  end

  def initialize(comment)
    @comment = comment
  end

  def call
    return if mentioned_usernames.empty?

    users = User.where(username: mentioned_usernames)
                .where.not(id: @comment.user_id)

    users.each do |user|
      Notification.create!(
        user: user,
        actor: @comment.user,
        comment: @comment
      )
    end
  end

  private

  def mentioned_usernames
    @mentioned_usernames ||= @comment.body.scan(USERNAME_MENTION_REGEX).flatten.uniq
  end
end
