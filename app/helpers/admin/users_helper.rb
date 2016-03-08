module Admin::UsersHelper
  def link_to_vk(uid)
    link_to 'user_vk_url', "https://vk.com/id#{uid}"
  end

  def message(user)
    url = user.message ? user.message.image.url : 'no_image_url'
    message = user.message ? user.message.message : 'no_message'

    content_tag(:div, id: 'message') do
       concat(content_tag(:div, "message: #{message}"))
       concat(content_tag(:div, "uploaded image:"))
       concat(image_tag(url))
    end
  end
end