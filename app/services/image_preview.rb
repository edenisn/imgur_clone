class ImagePreview
  ALLOW_THUMB_SIZES = %w( 100x100 150x200 300x200 200x200 )

  def self.matches?(params)
    puts params.inspect
    if ALLOW_THUMB_SIZES.include? params
      true
    else
      false
    end
  end

  def self.resize(image, width, height)
    image = Magick::Image.read(image).first
    new_image = image.resize(width, height)
    new_image
  end

  def self.store(preview_id, width, height)
    file_path = "public/previews/#{preview_id}_#{width}_#{height}.jpg"

    preview = Preview.find_by(filename: File.basename(file_path))

    unless preview
      Preview.create!(filename: File.basename(file_path))

      s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION_FOR_CACHE'])
      object_upload = s3.bucket('images-cache').object(File.basename(file_path))
      object_upload.upload_file(File.open(File.join(Rails.root, file_path)))
    end
  end
end