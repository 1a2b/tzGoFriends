class Message < ActiveRecord::Base
  has_many :users
  validates :image, presence: true

  has_attached_file :image, default_url: '/images/:style/default.jpeg'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
