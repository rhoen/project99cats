class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true

  after_initialize :new_session_token

  def self.find_by_credentials(user_name, password)
    user = self.find_by_user_name(user_name)
    user if user.is_password?(password)
  end

  def new_session_token
    self.session_token || self.reset_session_token!
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
     BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
