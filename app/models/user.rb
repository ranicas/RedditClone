class User < ActiveRecord::Base
  
  attr_reader :password
  
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true, uniqueness: true
  validates :password, length: { minimum:  3, allow_nil: true }
  
  before_validation :ensure_session_token
  
  def self.authenticate_user(username, password)
    user = User.find_by(username: username)
    
    if !user.nil? && user.is_password?(password)
      user
    else
      nil
    end
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password) 
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
end
