class ImagePreview
  def self.image_resize(image, width, height)
    img = Magick::Image.read(image).first
    new_img = img.resize(width, height)
    new_img
  end

  def self.store_to_s3(file_path)
    preview = Preview.find_by(filename: File.basename(file_path))

    unless preview
      Preview.create!(filename: File.basename(file_path))

      AWS::S3::DEFAULT_HOST.replace("s3-ap-southeast-1.amazonaws.com")
      AWS::S3::Base.establish_connection!(access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
                                          secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'))

      AWS::S3::S3Object.store(File.basename(file_path),
                              File.open(File.join(Rails.root, file_path)),
                              'images-cache')
    end
  end
end