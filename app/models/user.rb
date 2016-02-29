class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true

  def self.set_user_by_vk(uid)
    User.where(uid: uid).first_or_create(uid)
  end
end
