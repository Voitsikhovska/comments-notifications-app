# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding users..."

users = [
  { username: "alice",   email: "alice@example.com" },
  { username: "bob",     email: "bob@example.com" },
  { username: "charlie", email: "charlie@example.com" },
  { username: "diana",   email: "diana@example.com" }
].map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |u|
    u.username = attrs[:username]
    u.password = "Password1!"
    u.password_confirmation = "Password1!"
  end
end

puts "Seeding comments..."

comments = [
  { user: users[0], body: "Hey everyone! Just joined CommentHub. Excited to be here 🎉" },
  { user: users[1], body: "Welcome @alice! Great to have you. This place is really growing fast." },
  { user: users[2], body: "Anyone else think dark mode would be a great addition to this app? 🌙" },
  { user: users[3], body: "Totally agree with @charlie — dark mode would be amazing. @alice you should suggest it!" },
  { user: users[0], body: "Ha, noted @diana! I'll add it to the wishlist. Also @bob thanks for the warm welcome 😊" },
  { user: users[1], body: "Just noticed you can mention people with @username — pretty neat feature." },
  { user: users[2], body: "Rails 8 is genuinely impressive. Solid Queue, Solid Cache, Solid Cable — all built in." },
  { user: users[3], body: "@charlie couldn't agree more. The defaults keep getting better every release." },
  { user: users[0], body: "What's everyone working on these days? I'm building a small side project with Hotwire." },
  { user: users[1], body: "@alice nice! Hotwire + Turbo Streams make real-time feel effortless. No JS framework needed." }
]

comments.each_with_index do |attrs, i|
  Comment.find_or_create_by!(body: attrs[:body]) do |c|
    c.user = attrs[:user]
    c.created_at = (comments.length - i).hours.ago
  end
end

puts "Done! #{User.count} users, #{Comment.count} comments."
