class SessionsController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]

  def new
    @vk_url = VkontakteApi.authorization_url(scope: [:photos], state: get_state)
  end

  def create
    redirect_to session_new_path, alert: 'Ошибка авторизации, попробуйте войти еще раз.' and return if get_state.present? && get_state != params[:state]

    vk = VkontakteApi.authorize(code: params[:code])
    user_info = vk.users.get(uid: session[:vk_id],
      fields: [:first_name,
               :last_name,
               :sex,
               :bdate,
               :city,
               :country,
               :photo_200_orig
              ]).first

    user = User.set_user_by_vk(vk.user_id, user_info)

    session[:token] = vk.token
    session[:vk_id] = vk.user_id
    session[:expires_at] = vk.expires_at
    session[:user_id] = user.id


    flash[:notice] = 'Вы успешно авторизировались'
    redirect_to root_url
  end

  def destroy
    close_session
    redirect_to root_path
  end

  private

  def get_state
    srand
    session[:state] ||= Digest::MD5.hexdigest(rand.to_s)
  end
end
