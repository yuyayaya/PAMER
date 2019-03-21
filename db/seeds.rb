# User data
user_first = User.new(name: "chandler",
                          number: "000 000 000",
                          email: "chanchan@gmail.com",
                          university: "Keio",
                          major: "math",
                          guide: true,
                          picture: open("#{Rails.root}/db/fixtures/PAM.png"),
                          password: "chanchan",
                          password_confirmation: "chanchan")
user_first.skip_confirmation!
user_first.save!

# Users data
25.times do |n|
  num = n + 1
  user = User.new(
    name: "user#{num}",
    email: "user#{num}@gmail.com",
    number: "00#{num} 0#{num} 000",
    university: "Keio",
    major: "math",
    guide: true,
    picture: open("#{Rails.root}/db/fixtures/PAM.png"),
    password: "password",
    password_confirmation: "password"
  )
  user.skip_confirmation!
  user.save!
end

25.times do |n|
  num = n + 26
  user = User.new(
    name: "user#{num}",
    email: "user#{num}@gmail.com",
    number: "00#{num} 0#{num} 000",
    university: "Waseda",
    major: "Japanese",
    guide: false,
    picture: open("#{Rails.root}/db/fixtures/PAM.png"),
    password: "password",
    password_confirmation: "password"
  )
  user.skip_confirmation!
  user.save!
end

users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.plans.create!(content: content) }
# end



