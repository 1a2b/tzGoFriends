class VkImageUploadWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'vk_image_upload'
  # sidekiq_options retry: false

  def perform(token, uid)
    ImageUploader.new(token, uid).upload
  end
end

