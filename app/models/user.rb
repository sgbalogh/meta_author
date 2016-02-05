class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :firstname,  presence: true, length: { maximum: 50 }
  validates :lastname,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :institution,  presence: true, length: { maximum: 255 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :records


end
