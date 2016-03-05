class HomeController < ApplicationController
  def index
    VkImageUploadWorker.perform_async(current_user.id)
    #ImageUploader.new(current_user.id).upload
  end

  private

  def update_all_users_basic_info
    user_ids = User.all
    user_ids.each do |user|
      user.update_basic_info
    end
  end
end
