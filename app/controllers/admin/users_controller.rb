class Admin::UsersController < ApplicationController
  skip_before_action :authorize

  def index
    @users = User.all
  end

  def show
    @user = User.find(user_params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:id, :uid)
  end
end