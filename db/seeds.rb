# User data
user_first = User.new(name: "chandler",
                          email: "chanchan@gmail.com",
                          # university: "Keio",
                          guide: true,
                          password: "chanchan",
                          password_confirmation: "chanchan")
 #user_first.skip_confirmation!
user_first.save!

# Users data
50.times do |n|
  num = n + 1
  user = User.new(
    name: "user#{num}",
    email: "user#{num}@gmail.com",
    # university: "Keio",
    guide: true,
    password: "password",
    password_confirmation: "password"
  )
  # user.skip_confirmation!
  user.save!
end

users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.plans.create!(content: content) }
# end
