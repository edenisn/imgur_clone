# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create!(username: "admin", email: "admin@imgurcloneapp.heroku.com",
              password: "admin123", password_confirmation: "admin123")

def seed_image(file_name, filename_extension)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{filename_extension}/#{file_name}.#{filename_extension}"))
end

1.upto(30) do |i|
  User.create!(email: "test#{i}@test.com", password: "12345678", password_confirmation: "12345678", username: "test#{i}")
  1.upto(10) do |j|
    Image.create!(name: "test#{j}", description: "test#{j}", attachment: seed_image("test#{j}", "jpg"),
                  created_at: Time.gm(2015, "sep", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
    Image.create!(name: "apple#{j}", description: "apple#{j}", attachment: seed_image("apple#{j}", "png"),
                  created_at: Time.gm(2015, "jun", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
  end
  1.upto(7) do |k|
    Image.create!(name: "devil#{k}", description: "devil#{k}", attachment: seed_image("devil#{k}", "gif"),
                  created_at: Time.gm(2015, "aug", "#{k}", "#{k}", "#{k}", 40, 50), user_id: i)
  end
  1.upto(4) do |n|
    Image.create!(name: "ruby#{n}", description: "ruby#{n}", attachment: seed_image("ruby#{n}", "jpeg"),
                  created_at: Time.gm(2015, "feb", "#{n}", "#{n}", "#{n}", 10, 50), user_id: i)
  end
end


