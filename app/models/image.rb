class Image < ActiveRecord::Base
  belongs_to :user

  before_create :default_name

  mount_uploader :attachment, AttachmentUploader

  MAX_FILE_SIZE = 4500000 # maximum image size in bytes

  validates :attachment,
            presence: true,
            file_size: {
                less_than: 5.megabytes
            }

  def default_name
    self.name ||= File.basename(attachment.filename, '.*').titleize if attachment
  end

  def self.search(query)
    where("description like ?", "%#{query}%")
  end

  def self.uploads_before_day(day)
    where("created_at <= ?", day)
  end

  def self.uploads_by_hour_of_day(upload_day)
    where("created_at >= ? AND created_at <= ?", upload_day.beginning_of_day, upload_day.end_of_day)
  end

  def self.uploads_before_day_and_by_content_type(day, content_type)
    where("created_at <= ? AND content_type = ?", day, content_type)
  end

  def self.uploads_size_between(size_min, size_max)
    if size_min.present? && size_max == ''
      size_max = MAX_FILE_SIZE
    elsif size_min == '' && size_max.present?
      size_min = 0
    end

    where("file_size >= ? AND file_size <= ?", size_min, size_max)
  end
end
