class Dataset < ActiveRecord::Base

  mount_uploaders :multiattach, AttachmentUploader

  validates :name, presence: true
  serialize :multiattach, Array

  belongs_to :record
  belongs_to :user

end
