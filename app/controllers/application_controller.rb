class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize
  before_action :current_user

  helper_method :current_user

  def current_user
    return unless session[:user_id]
    User.find(session[:user_id])
  end

  protected

  def admin_autorize
    unless current_user.admin?
      flash[:error] = 'Вы должны войти как админ'
      redirect_to root_path
    end
  end

  def close_session
    reset_session
  end

  private

  def not_valid_session?
    session[:expires_at].nil? || session[:expires_at] <= Time.now
  end

  def authorize
    close_session if not_valid_session?
    unless current_user
      flash[:notice] = 'Пожалуйста, авторизируйтесь с помощью Вконтакте'
      redirect_to session_new_path
    end
  end
end
