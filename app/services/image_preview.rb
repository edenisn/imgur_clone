class ImagePreview
  def self.resize(image, width, height)
    image = Magick::Image.read(image).first
    new_image = image.resize(width, height)
    new_image
  end

  def self.file_path(preview_id, width, height)
    path = "public/previews/#{preview_id}_#{width}_#{height}.jpg"
  end

  def self.store_to_s3(preview_id, width, height)
    path = file_path(preview_id, width, height)

    preview = Preview.find_by(filename: File.basename(path))

    unless preview
      Preview.create!(filename: File.basename(path))

      s3 = Aws::S3::Resource.new(region:'ap-southeast-1')
      object_upload = s3.bucket('images-cache').object(File.basename(path))
      object_upload.upload_file(File.open(File.join(Rails.root, path)))
    end
  end
end