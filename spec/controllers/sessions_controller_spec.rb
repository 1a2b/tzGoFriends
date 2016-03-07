require 'rails_helper'

describe SessionsController do
  let (:message) { create(:message) }
  let (:user) { create(:user, message_id: message.id) }

   before do
     allow(controller).to receive(:get_state) { 'MD5 hash' }
   end

  describe '#new' do
    it 'renders session new' do
      VkontakteApi.should_receive(:authorization_url).once.with(scope: [:photos], state: 'MD5 hash').and_return('link')
      get :new
      expect(assigns(:vk_url)).to eq('link')
    end
  end

  describe '#create' do
    it 'redirect to log_in_path' do
      post :create , state: 'Another MD5 hash'
      expect(response).to redirect_to log_in_path
      expect(flash[:alert]).to match(/Ошибка авторизации, попробуйте войти еще раз./)
    end

    it 'update session & user' do
      time = "#{Time.now + 1.day}"

      vk = VkontakteApi::Client.new
      vk.instance_variable_set('@user_id', user.uid)
      vk.instance_variable_set('@token', 'token')
      vk.instance_variable_set('@expires_at', time)

      VkontakteApi.should_receive(:authorize).once.with(code: 'code').and_return(vk)
      post :create , state: 'MD5 hash', code: 'code'

      expect(session[:user_id]).to eq(user.id)
      expect(session[:expires_at]).to eq(vk.expires_at)
      expect(response).to redirect_to root_path

      expect(flash[:notice]).to match(/Вы успешно авторизировались, мы загрузили вам картинку в альбом/)
    end
  end

  describe '#destroy' do
    it 'close session and redirect' do
      session[:user_id] = user.id
      allow(controller).to receive(:current_user) { user }

      delete :destroy

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to match(/Вы успешно вышли из приложения/)
    end
  end
end
