# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed_image(file_name, filename_extension)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{filename_extension}/#{file_name}.#{filename_extension}"))
end

1.upto(1000) do |i|
  User.create!(email: "test#{i}@test.com", password: "12345678", password_confirmation: "12345678", username: "test#{i}")
  1.upto(10) do |j|
    Image.create!(name: "test#{j}", description: "test#{j}", attachment: seed_image("test#{j}", "jpg"),
                  created_at: Time.gm(2015, "sep", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
    Image.create!(name: "apple#{j}", description: "apple#{j}", attachment: seed_image("apple#{j}", "png"),
                  created_at: Time.gm(2015, "jun", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
    Image.create!(name: "devil#{j}", description: "devil#{j}", attachment: seed_image("devil#{j}", "gif"),
                  created_at: Time.gm(2015, "aug", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
    Image.create!(name: "ruby#{j}", description: "ruby#{j}", attachment: seed_image("ruby#{j}", "jpeg"),
                  created_at: Time.gm(2015, "feb", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
  end
end


