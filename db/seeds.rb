# User1
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

# user1からuser25まで旅行者
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

tags = ["Food&Drink", "Alchol", "Event", "Activity", "Trend", "Secret Spot", "Shopping", "School", "Kawaii"]
# user26からuser50までガイド
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
  user.plans.create!(
    name: "user#{num}_plan",
    content: Faker::Lorem.paragraph_by_chars(140, false),
    image: open("#{Rails.root}/db/fixtures/student-only.jpg"),
    tag: tags.sample
  )
end

10.times do |n| # 旅行者はuser1からuser10
  tourist = User.find(n + 2)
  5.times do |m| # ガイドはuser26からuser30
    guide = User.find(m + 27)
    tourist.active_requests.create!(
      guide_id: guide.id,
      plan_id: guide.plans.first.id,
      approved: true
    )
  end
end
