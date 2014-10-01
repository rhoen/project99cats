class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    #@user.password = user_params[:user][:password]
    if @user.save
      redirect_to user_url #LOOK AT THIS LATER
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
