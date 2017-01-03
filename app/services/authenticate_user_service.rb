class AuthenticateUserService
  include Serviceable
  include StatusObject

  delegate :locked?, to: :@user

  def initialize(user, password)
    @user = user
    @password = password
  end

  def call
    return Status.new(success: false, notice: '用户名或密码错误', user: @user) if !validated?
    Status.new(success: true, notice: '登陆成功', user: @user)
  end

  private
  def password_correct?
    @user.encrypted_password == @user.encrypt_with_salt(@password, @user.salt)
  end

  def validated?
    @user.present? && password_correct?
  end

end
