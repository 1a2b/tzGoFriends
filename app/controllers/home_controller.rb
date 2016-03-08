class HomeController < ApplicationController
  def index
    VkImageUploadWorker.perform_async(current_user.id)
    #ImageUploader.new(current_user.id).upload
  end
end
