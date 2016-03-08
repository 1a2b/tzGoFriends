class Message < ActiveRecord::Base
  has_many :users
  validates :image, presence: true

  has_attached_file :image,
    storage: :dropbox,
    dropbox_credentials: Rails.root.join("config/dropbox.yml"),
    path: ":style/:id_:filename"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
