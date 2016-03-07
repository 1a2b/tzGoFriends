require 'rails_helper'

describe ApplicationController do
  let (:message) { create(:message) }
  let (:admin) { create(:admin, message_id: message.id) }
  let (:user) { create(:user, message_id: message.id) }

  describe 'current_user' do
    it 'returns user' do
      session[:user_id] = user.id
      expect(controller.current_user).to eq(user)
    end

    it 'returns nil' do
      session[:user_id] = nil
      expect(controller.current_user).to eq(nil)
    end
  end

  describe 'close_session' do
    it 'clears session' do
      session[:user_id] = user.id
      controller.send(:close_session)
      expect(session).to be_empty
    end
  end

  describe 'not_valid_session?' do
    it 'returns true' do
      session[:expires_at] = nil
      expect(controller.send(:not_valid_session?)).to eq(true)
      session[:expires_at] = Time.now - 5.days
      expect(controller.send(:not_valid_session?)).to eq(true)
    end

    it 'returns false' do
      session[:expires_at] = Time.now + 5.days
      expect(controller.send(:not_valid_session?)).to eq(false)
    end
  end
end
