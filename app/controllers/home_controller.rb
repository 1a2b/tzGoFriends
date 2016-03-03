class HomeController < ApplicationController
  def index
    VkImageUploadWorker.perform_async(session[:token], current_user.uid)
    User.update_all_users_basic_info
  end
end
