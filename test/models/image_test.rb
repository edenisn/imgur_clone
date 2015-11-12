require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    @image = images(:image1)
  end

  test "has an attachment" do
    assert File.exists?(@image.attachment.file.path)
  end

  test "uploads an attachment" do
    @image1 = Image.create!(name: "test_test", attachment: fixture_file_upload('/files/test.jpg', 'image/jpg'))
    assert(File.exists?(@image1.reload.attachment.file.path))
  end

  test "should not save image without attachment" do
    assert_raise("Attachment can't be blank") {
      Image.create!(name: "test_image")
    }
  end

  test "should not search image(s) with description 'car'" do
    images = Image.search("car")
    assert_equal(0, images.count)
  end

  test "should search image(s) with description 'descr'" do
    images = Image.search("descr")
    assert_equal(1, images.count)
  end

  test "should not search image(s) upload before day <= today - 7.days" do
    images = Image.uploads_before_day(DateTime.now.utc - 7.days)
    assert_equal(0, images.count)
  end

  test "should search image(s) upload before day <= today" do
    images = Image.uploads_before_day(DateTime.now.utc)
    assert_equal(1, images.count)
  end

  test "should not search image(s) upload by hour of day = 01.01.2000" do
    images = Image.uploads_by_hour_of_day(Date.new(2000, 1, 1))
    assert_equal(0, images.count)
  end

  test "should search image(s) upload by hour of day = 01.01.2010" do
    @image1 = Image.create!(name: "test", attachment: fixture_file_upload('/files/test.jpg', 'image/jpg'),
                           created_at: Date.new(2010, 1, 1))
    images = Image.uploads_by_hour_of_day(Date.new(2010, 1, 1))
    assert_equal(1, images.count)
  end

  test "should not search image(s) upload before day = today and content_type = gif " do
    images = Image.uploads_before_day_and_by_content_type(DateTime.now.utc, "image/gif")
    assert_equal(0, images.count)
  end

  test "should search image(s) upload before day <= today and content_type = jpeg " do
    images = Image.uploads_before_day_and_by_content_type(DateTime.now.utc, "image/jpeg")
    assert_equal(1, images.count)
  end

  test "should not search image(s) upload between min size and max size of image" do
    images = Image.uploads_size_between(30000, 50000)
    assert_equal(0, images.count)
  end

  test "should search image(s) upload between min size and max size of image" do
    images = Image.uploads_size_between(15000, 25000)
    assert_equal(1, images.count)
  end
end
