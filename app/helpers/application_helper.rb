module ApplicationHelper
  def highlight_mentions(text)
    safe_text = h(text)
    safe_text.gsub(/@([a-zA-Z0-9_]+)/) do |_match|
      username = Regexp.last_match(1)
      link_to "@#{username}", user_profile_path(username: username), class: "mention"
    end.html_safe
  end
end
