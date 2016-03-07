require 'rails_helper'

describe Admin::UsersController do
  let (:message) { create(:message) }
  let (:admin) { create(:admin, message_id: message.id) }
  let (:user) { create(:user, message_id: message.id) }
  let! (:users) { create_list(:user, 2, message_id: message.id) }

  context 'log_in as admin' do
    before do
      allow(controller).to receive(:current_user) { admin }
    end

    describe '#index' do
      it 'shows all users' do
        get :index

        expect(assigns(:users).count).to equal(3)
        expect(assigns(:users)).to eq(users << admin)
      end

      it 'returns 200 status' do
        get :index
        expect(response.status).to equal(200)
      end
    end

    describe '#update' do
      it 'update user' do
        put :update, id: user.id, user: { message_id: message.id }

        expect(response).to redirect_to admin_users_path
        expect(flash[:success]).to match(/Вы успешно обновили юзера/)
      end
    end

    describe 'update_all_users' do
      it 'update all users' do
        allow(controller).to receive(:update_all_users_basic_info)
        put :update_all_users
        expect(response).to redirect_to admin_users_path
        expect(flash[:success]).to match(/Юзеры обновленны/)
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

    describe '#update' do
      it 'not update message' do
        put :update, id: 1
      end
    end

    describe 'update_all_users' do
      it 'not update all users' do
        put :update_all_users
      end
    end
  end
end
