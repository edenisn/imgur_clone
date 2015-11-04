require 'file_size_validator'

class Image < ActiveRecord::Base
  belongs_to :user

  mount_uploader :attachment, AttachmentUploader

  validates :name, presence: true

  validates :attachment,
            :presence => true,
            :file_size => {
                :maximum => 5.megabytes.to_i
            }
end
