class Admin::MessagesController < ApplicationController
  before_action :admin_autorize

  def index
    @messages = Message.all
    @message = Message.new
  end

  def create
    message = Message.new(message_params)

    if message.save
      flash[:success] = 'Сообщение создано'
    else
      flash[:error] = 'Сообщение не создано'
    end

    redirect_to admin_messages_path
  end

  def update
    message = find_message

    if message.update_attributes(message_params)
      flash[:success] = 'Сообщение обновлено'
    else
      flash[:error] = 'Сообщение не обновлено'
    end

    redirect_to admin_messages_path
  end

  private

  def find_message
    Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:message, :image)
  end
end