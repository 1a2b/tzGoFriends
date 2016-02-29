class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize
  before_filter :current_user

  helper_method :logged_in?
  helper_method :current_user

  def current_user
    return unless session[:user_id]
    User.find(session[:user_id])
  end

  def logged_in?
    session[:token].present?
  end

  protected

  def close_session
    reset_session
    flash[:notice] = 'Вы успешно разлогинились'
  end

  private

  def not_valid_session?
    session[:expires_at].nil? || session[:expires_at] <= Time.now
  end

  def authorize
    close_session if not_valid_session?
    flash[:notice] = 'Please Log in'
    redirect_to session_new_path unless logged_in?
  end
end
