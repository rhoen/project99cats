class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def login_user!(credentials)
    user_name, password = credentials[:user_name], credentials[:password]
    @current_user = User.find_by_credentials(user_name, password)
    if @current_user
      @current_user.reset_session_token!
      session[:session_token] = @current_user.session_token
    end
  end

  helper_method :current_user, :signed_in?, :user_is_owner?



  private

  def session_params
    params.require(:session).permit(:user_name, :password)
  end

  def require_current_user
    redirect_to(new_session_url) unless signed_in?
  end

  def require_no_user
    redirect_to(root_url) if signed_in?
  end

  def check_user_is_owner
    redirect_to cat_url(params[:id]) unless user_is_owner?
  end

  def user_is_owner?
    current_user && Cat.find(params[:id]).owner_id == current_user.id
  end

end
