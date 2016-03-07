require 'rails_helper'

describe HomeController do
  let (:message) { create(:message) }
  let (:user) { create(:user, message_id: message.id) }

   before do
     allow(controller).to receive(:current_user) { user }
   end

  describe '#index' do
    it 'run uploading image' do
      VkImageUploadWorker.should_receive(:perform_async).once.with(user.id)
      get :index
    end
  end
end
