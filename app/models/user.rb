class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  def self.set_user_by_vk(uid, user_info)
    User.where(uid: uid).first_or_create do |user|
      user.first_name = user_info[:first_name]
      user.last_name = user_info[:last_name]
      user.bdate = user_info[:bdate]
      user.city = user_info[:city][:title]
      user.country = user_info[:country][:title]
      user.photo = user_info[:photo_200_orig]
      case user_info[:sex]
      when 1
        user.sex = 'Женский'
      when 2
        user.sex = 'Мужской'
      else
        user.sex = 'пол не указан'
      end
    end
  end
end
