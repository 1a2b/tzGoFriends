require 'rails_helper'

describe ImageUploader do
  let (:user) { create(:user, token: 'token', message_id: message.id) }
  let (:message) { create(:message) }

  before do
    @uploader = ImageUploader.new(user.id)
  end

  describe 'upload' do
    it 'run uploads methods' do
      allow(@uploader).to receive(:need_to_post_image?) { true }
      @uploader.should_receive(:upload_img).once
      @uploader.should_receive(:update_user_uploads_info).once

      @uploader.upload
    end

    it 'does not run uploads methods' do
      allow(@uploader).to receive(:need_to_post_image?) { false }
      @uploader.should_receive(:upload_img).exactly(0).times
      @uploader.should_receive(:update_user_uploads_info).exactly(0).times

      @uploader.upload
    end
  end

  describe 'need_to_post_image?' do
    it 'returns true' do
      user.update(last_post_at: Time.now - 2.day)
      @uploader.instance_variable_set('@user', user)
      expect(@uploader.send(:need_to_post_image?)).to eq(true)
    end

    it 'return false' do
      user.update(last_post_at: Time.now)
      @uploader.instance_variable_set('@user', user)
      expect(@uploader.send(:need_to_post_image?)).to eq(false)
    end
  end

  describe 'update_user_uploads_info' do
    it "update user info" do
      @user = create(:user, token: 'token', message_id: message.id)
      @uploader.instance_variable_set('@user', @user)

      @uploader.send(:update_user_uploads_info)
      expect(@user.posted_message_id).to eq(@user.message_id)
    end
  end
end