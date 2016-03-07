require 'rails_helper'

describe User, type: :model do
  let (:admin) { create(:admin, message_id: message.id) }
  let (:user) { create(:user, message_id: message.id) }
  let (:message) { create(:message) }

  it { is_expected.to validate_presence_of :uid }
  it { is_expected.to validate_uniqueness_of :uid }
  it { is_expected.to belong_to :message }

  describe 'admin?' do
    it 'returns true' do
      expect(admin.admin?).to be_truthy
    end

    it 'returns false' do
      expect(user.admin?).to be_falsey
    end
  end

  describe 'set_user_by_vk' do
    it 'returns user' do
      expect(User.set_user_by_vk(user.uid)).to eq(user)
    end

    it 'returns new user' do
      User.set_user_by_vk(0)
      expect(User.count).to equal(1)
    end
  end

  describe 'update_token' do
    it 'updates user token' do
      user.update_token('token', '1')
      expect(user.token).to eq('token')
    end
  end

  describe 'update_basic_info' do
    it 'updates user update_basic_info' do
      user.should_receive(:get_vk_users_info).once.with([user.uid]).and_return(['params'])
      user.should_receive(:update_user).once.with('params')

      user.update_basic_info
    end
  end

  describe 'update_user' do
    it 'updates user update_basic_info' do
      user_info = { id: user.uid, first_name: 'Denis' }
      user.should_receive(:get_user_hash).once.with(user_info)
        .and_return({first_name: 'Denis'})

      expect(user.send(:update_user, user_info)).to eq(true)
      expect(User.last.first_name).to eq('Denis')
    end
  end

  describe 'get_user_hash' do
    it 'updates user update_basic_info' do
      user_info = { id: user.uid, first_name: 'Denis', sex: 1}
      result = user.send(:get_user_hash, user_info)
      expect(result).to eq({ :first_name=>"Denis",
                             :last_name=>"не указан",
                             :bdate=>"не указан",
                             :city=>"не указан",
                             :country=>"не указан",
                             :photo=>nil,
                             :sex=>"Женский"
                           })
    end
  end

  describe 'get_sex' do
    it 'return Мужской' do
      expect(user.send(:get_sex, 2)).to eq('Мужской')
    end
    it 'return Женский' do
      expect(user.send(:get_sex, 1)).to eq('Женский')
    end
  end
end
