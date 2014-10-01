class SessionsController < ApplicationController
  before_action :require_no_user, only: :new

  def create
    login_user!(session_params)
    if current_user
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

end
