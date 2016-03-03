class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true

  def self.set_user_by_vk(uid)
    User.where(uid: uid).first_or_create(uid)
  end

  def self.update_all_users_basic_info
    vk = VkontakteApi::Client.new
    user_ids = User.all.pluck(:uid)
    vk_users = vk.users.get(user_ids: user_ids,
      fields: [:first_name,
               :last_name,
               :sex,
               :bdate,
               :city,
               :country,
               :photo_200_orig
              ])
    vk_users.each do |user_info|
      update_user(user_info)
    end
  end

  private

  def update_user(user_info)
    user = User.find_by_uid(user_info[:id])
    user.update(get_user_hash(user_info))
  end

  def get_sex(sex)
    sex == 1 ? 'Женский' : 'Мужской'
  end

  def get_user_hash(user_info)
    {
      first_name: user_info[:first_name] || 'не указан',
      last_name: user_info[:last_name] || 'не указан',
      bdate: user_info[:bdate] || 'не указан',
      city: user_info[:city].try(:title) || 'не указан',
      country: user_info[:country].try(:title) || 'не указан',
      photo: user_info[:photo_200_orig],
      sex: get_sex(user_info[:sex])
    }
  end
end
