class HomeController < ApplicationController
  def index
    VkImageUploadWorker.perform_async(session[:token], current_user.uid)
  end
end
