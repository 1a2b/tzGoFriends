class VkImageUploadWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'vk_image_upload'
  sidekiq_options retry: false

  def perform(id)
    ImageUploader.new(id).upload
  end
end

