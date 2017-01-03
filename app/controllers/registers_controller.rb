class RegistersController < ApplicationController
  layout 'thiny'
  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      redirect_to new_register_path, notice: @user.errors.messages.first
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
