class Admin::UsersController < ApplicationController
  before_action :admin_autorize

  def index
    @users = User.all
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      flash[:success] = 'Вы успешно обновили юзера'
    else
      flash[:error] = 'Вы не обновили юзера'
    end

    redirect_to admin_users_path
  end

  def update_all_users
    update_all_users_basic_info
    flash[:success] = 'Юзеры обновленны'
    redirect_to admin_users_path
  end

  private

  def update_all_users_basic_info
    User.all.each { |user| user.update_basic_info }
  end

  def user_params
    params.require(params[:user] ? :user : :admin).permit(:uid, :image, :message_id)
  end
end