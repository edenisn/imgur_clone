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
  File.open(File.join(Rails.root, "/tmp/build_d0c3e09e06aa3677381c6ece4920a617/public/assets/seed/#{filename_extension}/#{file_name}.#{filename_extension}"))
end

1.upto(30) do |i|
  User.create!(email: "test#{i}@test.com", password: "12345678", password_confirmation: "12345678", username: "test#{i}")
  1.upto(10) do |j|
    Image.create!(name: "test#{j}", description: "test#{j}", attachment: seed_image("test#{j}-6b9a63391e7e5663766a37ad764843d0a7754ec07b4b6ba480f9016e0516a643", "jpg"),
                  created_at: Time.gm(2015, "sep", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
    Image.create!(name: "apple#{j}", description: "apple#{j}", attachment: seed_image("apple#{j}-df7e08fb7969d86ba50798b071c29a5a7560e5603a60440012fb474db5654fd0", "png"),
                  created_at: Time.gm(2015, "jun", "#{j}", "#{j}", "#{j}", 30, 50), user_id: i)
  end
  1.upto(7) do |k|
    Image.create!(name: "devil#{k}", description: "devil#{k}", attachment: seed_image("devil#{k}-4a252f293da5520ce9a31bea09dd7c6fbb0747cb94472349eb16deefbe2a4e1c", "gif"),
                  created_at: Time.gm(2015, "aug", "#{k}", "#{k}", "#{k}", 40, 50), user_id: i)
  end
  1.upto(4) do |n|
    Image.create!(name: "ruby#{n}", description: "ruby#{n}", attachment: seed_image("ruby#{n}-f08f776bb464fc45f7d9a2548afe213db558773258adc4adad341d70189c43be", "jpeg"),
                  created_at: Time.gm(2015, "feb", "#{n}", "#{n}", "#{n}", 10, 50), user_id: i)
  end
end


