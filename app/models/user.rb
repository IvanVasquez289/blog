class User < ApplicationRecord
  before_validation {self.email = email.downcase}
  has_many :articles , dependent: :destroy
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum:3, maximum:25 }
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum:105 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end