module ApplicationHelper
  def highlight_mentions(text)
    safe_text = h(text)
    safe_text.gsub(/@([a-zA-Z0-9_]+)/) do |match|
      content_tag(:strong, match, class: "mention")
    end.html_safe
  end
end
