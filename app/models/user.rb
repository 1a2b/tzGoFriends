class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  belongs_to :message

  def admin?
    self.type == 'Admin'
  end

  def self.set_user_by_vk(uid)
    User.where(uid: uid).first_or_create(uid: uid, message_id: 1)
  end

  def update_token(token, expires_at)
    self.update(token: token, token_expires_at: expires_at)
  end

  def update_basic_info
    vk_user_info = get_vk_users_info([self.uid]).first
    update_user(vk_user_info)
  end

  def update_user(user_info)
    user = User.find_by_uid(user_info[:id])
    user.update(get_user_hash(user_info))
  end

  def get_vk_users_info(user_ids)
    vk = VkontakteApi::Client.new
    vk_users = vk.users.get(user_ids: user_ids,
      fields: [:first_name,
               :last_name,
               :sex,
               :bdate,
               :city,
               :country,
               :photo_200_orig
              ])
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

  def get_sex(sex)
    sex == 1 ? 'Женский' : 'Мужской'
  end

end
