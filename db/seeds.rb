# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding users..."

users = [
  { username: "alice",   email: "alice@example.com" },
  { username: "bob",     email: "bob@example.com" },
  { username: "charlie", email: "charlie@example.com" },
  { username: "diana",   email: "diana@example.com" },
  { username: "evan",    email: "evan@example.com" },
  { username: "fiona",   email: "fiona@example.com" },
  { username: "george",  email: "george@example.com" },
  { username: "hannah",  email: "hannah@example.com" }
].map do |attrs|
  User.find_or_create_by!(email: attrs[:email]) do |u|
    u.username = attrs[:username]
    u.password = "Password1!"
    u.password_confirmation = "Password1!"
  end
end

alice, bob, charlie, diana, evan, fiona, george, hannah = users

puts "Seeding comments..."

comments = [
  { user: alice,   body: "Hey everyone! Just joined CommentHub. Excited to be here 🎉" },
  { user: bob,     body: "Welcome @alice! Great to have you. This place is really growing fast." },
  { user: charlie, body: "Anyone else think dark mode would be a great addition? 🌙 @alice @diana what do you think?" },
  { user: diana,   body: "Totally agree with @charlie — dark mode would be amazing. @alice you should suggest it!" },
  { user: alice,   body: "Ha, noted @diana! I'll add it to the wishlist. Also @bob thanks for the warm welcome 😊" },
  { user: evan,    body: "Hey all! First time posting here. @alice love the energy in this community." },
  { user: fiona,   body: "Rails 8 is genuinely impressive. Solid Queue, Solid Cache, Solid Cable — all built in. @george you'd love it." },
  { user: george,  body: "@fiona couldn't agree more. The defaults keep getting better every release. @charlie have you tried it?" },
  { user: charlie, body: "@george yes! The asset pipeline is so much simpler now. @evan @fiona worth migrating old apps?" },
  { user: hannah,  body: "Just discovered this app through @diana — really clean UI! Who built it?" },
  { user: bob,     body: "@hannah @alice built it! Amazing work honestly. The mention feature is super slick." },
  { user: alice,   body: "Thanks @bob and @hannah! Still lots to add. @evan @fiona @george any feature requests?" },
  { user: evan,    body: "@alice I'd love a way to search comments. Also reactions would be fun 🔥" },
  { user: fiona,   body: "+1 to @evan — search would be really useful. @charlie @bob what do you think?" },
  { user: diana,   body: "I'd love to see threaded replies! @alice @george has anyone worked on that before?" },
  { user: george,  body: "@diana threaded replies are tricky but doable with Hotwire. @charlie and I prototyped something once." },
  { user: charlie, body: "@george yes! Turbo Frames made it surprisingly clean. @alice @diana happy to share the approach." },
  { user: hannah,  body: "This is such a good discussion 👏 @charlie @george please do share! @fiona @evan are you following along?" },
  { user: bob,     body: "@alice nice! Hotwire + Turbo Streams make real-time feel effortless. No JS framework needed." },
  { user: alice,   body: "What's everyone working on these days? I'm building a small side project with Hotwire. @evan @fiona @george curious what your stacks look like." }
]

comments.each_with_index do |attrs, i|
  Comment.find_or_create_by!(body: attrs[:body]) do |c|
    c.user = attrs[:user]
    c.created_at = (comments.length - i).hours.ago
  end
end

puts "Done! #{User.count} users, #{Comment.count} comments, #{Notification.count} notifications."
