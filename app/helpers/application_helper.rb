module ApplicationHelper

  def admin?
    current_user && current_user.admin?
  end

  def auth_buttons
    if current_user
      link_to 'Выйти', log_out_path, method: :delete, class: 'btn btn-primary log_out'
    else
      link_to 'Войти с помощью вк', @vk_url, class: 'btn btn-primary log_in right'
    end
  end

  def bootstrap_class_for flash_type
    case flash_type
      when 'success'
        'alert-success' # Green
      when 'error'
        'alert-danger' # Red
      when 'alert'
        'alert-warning' # Yellow
      when 'notice'
        'alert-info' # Blue
      else
        flash_type.to_s
    end
  end
end
