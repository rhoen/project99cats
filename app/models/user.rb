class User < ActiveRecord::Base

  attr_reader :password

  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :new_session_token

  has_many :sessions

  has_many :cats

  has_many :owned_cat_rental_requests, through: :cats, source: :cat_rental_requests

  has_many :cat_rental_requests

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    user if user.is_password?(password)
  end

  def new_session_token(device = nil, ip = nil)
    new_session_token = SecureRandom.base64(16)
    if self.id
      Session.create!(
        user_id: self.id,
        session_token: new_session_token,
        device: device,
        ip: ip
      )
    end
    new_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
     BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
