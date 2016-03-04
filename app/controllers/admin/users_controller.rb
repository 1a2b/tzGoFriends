class Admin::UsersController < ApplicationController
  skip_before_action :authorize
  before_action :admin_autorize

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
  end


  def upload_image

  end

  private

  def admin_autorize
    unless current_user.admin?
      flash[:error] = 'You need to login as admin'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:uid, :image, :message_id)
  end
end