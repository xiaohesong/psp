class SessionsController < ApplicationController
  layout 'thiny'
  before_action :set_user, only: [:create]
  def new

  end

  def create
    @status = AuthenticateUserService.call(@user, params[:password])
    if @status.success?
      session[:user_id] = @user.id
      @user.login!(request.env['HTTP_USER_AGENT'])
      redirect_to root_path
    else
      redirect_to new_session_path, notice: @status.notice
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  private
  def set_user
    @user = User.find_by(email: params[:email])
  end
end
