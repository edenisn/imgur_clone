class Image < ActiveRecord::Base
  belongs_to :user

  before_create :default_name

  mount_uploader :attachment, AttachmentUploader

  validates :attachment,
            presence: true,
            file_size: {
                less_than: 5.megabytes
            }

  def default_name
    self.name ||= File.basename(attachment.filename, '.*').titleize if attachment
  end
end
