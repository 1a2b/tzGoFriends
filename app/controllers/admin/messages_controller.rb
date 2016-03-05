class Admin::MessagesController < ApplicationController
  before_action :admin_autorize
  skip_before_action :verify_authenticity_token

  def index
    @messages = Message.all
    @message = Message.new
  end

  def show
    @message = find_message
  end

  def create
    Message.create(message_params)

    redirect_to_admin_message('Message created')
  end

  def update
    message = find_message
    message.update_attributes(message_params)

    redirect_to_admin_message('Message updated')
  end

  private

  def redirect_to_admin_messages(msg)
    flash[:notice] = msg
    redirect_to admin_messages_path
  end

  def find_message
    Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:message, :image)
  end
end