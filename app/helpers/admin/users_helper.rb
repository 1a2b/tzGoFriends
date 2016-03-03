module Admin::UsersHelper
  def link_to_vk(uid)
    link_to 'user_vk_url', "https://vk.com/id#{uid}"
  end
end