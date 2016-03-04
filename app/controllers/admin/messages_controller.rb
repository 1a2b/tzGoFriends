class Admin::MessagesController < ApplicationController
  skip_before_action :authorize
  before_action :admin_autorize
  skip_before_action :verify_authenticity_token

  def index
    @messages = Message.all
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    Message.create(message_params)
    redirect_to admin_messages_path
  end

  def update
    @message = Message.find(params[:id])
    @message.update_attributes(message_params)
    redirect_to admin_messages_path
  end

  private

  def admin_autorize
    unless current_user.admin?
      flash[:error] = 'You need to login as admin'
      redirect_to root_path
    end
  end

  def message_params
    params.require(:message).permit(:message, :image)
  end
end