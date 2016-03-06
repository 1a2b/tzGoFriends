module Admin::UsersHelper
  def link_to_vk(uid)
    link_to 'user_vk_url', "https://vk.com/id#{uid}"
  end

  def message(user)
    url = user.message.image.url
    message = user.message.message

    content_tag(:div, id: 'message') do
       concat(content_tag(:div, "message: #{message}"))
       concat(content_tag(:div, "uploaded image:"))
       concat(image_tag(url))
    end
  end
end