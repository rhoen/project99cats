class User < ActiveRecord::Base

  attr_reader :password

  validates :user_name, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :new_session_token

  has_many :cats

  has_many :owned_cat_rental_requests, through: :cats, source: :cat_rental_requests

  has_many :cat_rental_requests

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user if user.is_password?(password)
  end

  def new_session_token
    self.session_token = SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
     BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
