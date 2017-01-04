class User < ApplicationRecord
  attr_accessor :password, :password_confirmation

  validates_format_of  :email, :message => "邮箱格式不正确!", with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :update
  validates :password, confirmation: {message: '密码保持一致！'} , unless: ->(user){user.password.blank?}
  validates :email, presence: true, uniqueness: { message: "已经存在!" }
  before_create :encrypt_password

  EXPIRED_TIME = 5.minutes.ago

  scope :admin?, ->(status) { where(admin: status) }
  scope :onlines, -> { where("last_sign_in_at > ?", EXPIRED_TIME) }

  def encrypt_with_salt(txt, salt)
    Digest::SHA256.hexdigest("#{salt}#{txt}")
  end

  def password_connection?
    self.encrypted_password == self.encrypt_with_salt(self.password, self.salt)
  end

  def reset_password(new_password, pass_confirmation)
    self.password = new_password
    self.password_confirmation = pass_confirmation
    encrypt_password
  end

  def reset_password!(new_password, pass_confirmation)
    self.reset_password(new_password, pass_confirmation)
    self.save
  end

  def full_name
    "#{last_name}#{first_name}"
  end

  def login!(browser_info)
    Rails.logger.info browser_info * 10
    self.update!(last_sign_in_at: Time.now)
    $redis.set(browser_cache_key, browser_info)
  end

  def browser_cache_key
    "user_browser_#{self.id}"
  end

  private
  def encrypt_password
    self.salt = Digest::MD5.hexdigest("--#{Time.now.to_i}--")
    self.encrypted_password = self.encrypt_with_salt(self.password, self.salt)
  end

  def password_required?
     !password.nil? || !password_confirmation.nil?
  end
end
