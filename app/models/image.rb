class Image < ActiveRecord::Base
  belongs_to :user

  mount_uploader :attachment, AttachmentUploader

  validates :name, presence: true

  validates :attachment,
            presence: true,
            file_size: {
                less_than: 5.megabytes
            }
end
