class SessionsController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
    @vk_url = VkontakteApi.authorization_url(scope: [:photos], state: get_state)
  end

  def create
    redirect_to log_in_path, alert: 'Ошибка авторизации, попробуйте войти еще раз.' and return if get_state.present? && get_state != params[:state]

    vk = VkontakteApi.authorize(code: params[:code])
    user = User.set_user_by_vk(vk.user_id)

    session[:user_id] = user.id
    session[:expires_at] = vk.expires_at

    user.update_token(vk.token, vk.expires_at)
    user.update_basic_info

    flash[:notice] = 'Вы успешно авторизировались, мы загрузили вам картинку в альбом'
    redirect_to root_path
  end

  def destroy
    close_session

    flash[:notice] = 'Вы успешно вышли из приложения'
    redirect_to root_path
  end

  private

  def get_state
    srand
    session[:state] ||= Digest::MD5.hexdigest(rand.to_s)
  end
end
