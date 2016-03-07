require 'rails_helper'

describe Admin::UsersHelper do
  describe 'link_to_vk' do
    it 'generates vk link' do
      expect(helper.link_to_vk(123)).to eq(link_to 'user_vk_url', 'https://vk.com/id123')
    end
  end
end
