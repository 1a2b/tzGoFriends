class Admin::UsersController < ApplicationController
  before_action :admin_autorize

  def index
    @users = User.all
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_params)

    redirect_to_admin_users('Вы успешно обновили юзера')
  end

  private

  def redirect_to_admin_users(msg)
    flash[:notice] = msg
    redirect_to admin_users_path
  end

  def user_params
    return params.require(params[:user] ? :user : :admin).permit(:uid, :image, :message_id)
  end
end