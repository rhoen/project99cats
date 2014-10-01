class UsersController < ApplicationController

  before_action :require_no_user, only: :new

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    #@user.password = user_params[:user][:password]
    if @user.save
      login_user!(user_params)
      redirect_to root_url #LOOK AT THIS LATER
    else
      @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
