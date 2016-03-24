class Dataset < ActiveRecord::Base

  mount_uploaders :multiattach, AttachmentUploader

  serialize :multiattach, Array

  belongs_to :record
  belongs_to :user

end
