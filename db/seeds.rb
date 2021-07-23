User.create!(name: "Example Admin",
             email: "admin@gmail.com",
             password: "duong123",
             password_confirmation: "duong123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
50.times do |n|
  name = Faker::Name.name
  email = "admin-#{n+1}@gmail.com"
  password = "duong123"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
