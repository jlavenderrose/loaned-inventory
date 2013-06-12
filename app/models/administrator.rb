class Administrator < ActiveRecord::Base
  attr_accessible :password, :username, :fullname, :password_confirmation
  has_secure_password

  before_save :create_remember_token

  validates :username, :presence => true, :uniqueness => true
  validates :fullname, :presence => true
  validates :password, :confirmation => true, :presence => true
  validates :password_confirmation, :presence => true

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
	end
end
