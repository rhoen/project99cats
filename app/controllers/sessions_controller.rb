class SessionsController < ApplicationController
  before_action :require_no_user, only: :new

  def new
    @user = User.new
  end

  def index
    @sessions = User.find(params[:user_id]).sessions
  end

  def create
    login_user!(session_params)
    if current_user
      redirect_to root_url
    else
      @user = User.new(:user_name => session_params[:user_name])
      render :new
    end

  end

  def destroy
    current_session.destroy
    session[:session_token] = nil
    redirect_to cats_url
  end

end
