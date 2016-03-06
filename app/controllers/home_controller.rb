class HomeController < ApplicationController
  def index
    VkImageUploadWorker.perform_async(current_user.id)
  end
end
