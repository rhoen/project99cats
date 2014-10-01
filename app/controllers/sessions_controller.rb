class SessionsController < ApplicationController

  def create
    user_name, password = session_params[:user_name], session_params[:password]
    @current_user = User.find_by_credentials(user_name, password)
    if @current_user
      @current_user.reset_session_token!
      session[:session_token] = @current_user.session_token
      redirect_to root_url
    else
      redirect_to new_session_url
    end

  end

  def destroy
    current_user.reset_session_token! #THIS COULD BE A PROBLEM
    session[:session_token] = nil
    redirect_to cats_url
  end

  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
