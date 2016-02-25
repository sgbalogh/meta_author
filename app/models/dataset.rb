class Dataset < ActiveRecord::Base

  mount_uploader :attachment, AttachmentUploader
  validates :name, presence: true

  belongs_to :record

end
