require 'rails_helper'

describe Admin::MessagesController do
  let! (:messages) { create_list(:message, 2) }
  let (:message) { create (:message) }
  let (:admin) { create(:admin, message_id: messages.first.id) }
  let (:user) { create(:user, message_id: messages.first.id) }

  context 'log_in as admin' do
    before do
      allow(controller).to receive(:current_user) { admin }
    end

    describe '#index' do
      it 'shows all messages' do
        get :index

        expect(assigns(:messages).count).to equal(2)
        expect(assigns(:messages)).to eq(messages)
      end

      it 'returns 200 status' do
        get :index
        expect(response.status).to equal(200)
      end
    end

    describe '#create' do
      it 'create new message' do
        image = fixture_file_upload('images/default.jpg', 'image/jpg')
        post :create, message: { message: 'tzGoFriends', image: image }

        expect(response).to redirect_to admin_messages_path
        expect(flash[:success]).to match(/Сообщение создано/)
      end

      it 'not create new message' do
        image = nil
        post :create, message: { message: 'tzGoFriends', image: image }

        expect(response).to redirect_to admin_messages_path
        expect(flash[:error]).to match(/Сообщение не создано/)
      end
    end

    describe '#update' do
      it 'update message' do
        image = fixture_file_upload('images/default.jpg', 'image/jpg')
        put :update, id: message.id, message: { message: 'tzGoFriends', image: image }

        expect(response).to redirect_to admin_messages_path
        expect(flash[:success]).to match(/Сообщение обновлено/)
      end

      it 'not update message' do
        image = nil
        put :update, id: message.id, message: { message: 'tzGoFriends', image: image }

        expect(response).to redirect_to admin_messages_path
        expect(flash[:error]).to match(/Сообщение не обновлено/)
      end
    end
  end

  context 'log_in as user' do
    before do
      allow(controller).to receive(:current_user) { user }
    end

    after do
      expect(response).to redirect_to root_path
      expect(flash[:error]).to match(/Вы должны войти как админ/)
    end

    describe '#index' do
      it 'not shows all messages' do
        get :index
      end
    end

    describe '#create' do
      it 'not create new message' do
        post :create
      end
    end

    describe '#update' do
      it 'not update message' do
        put :update, id: 1
      end
    end
  end
end
