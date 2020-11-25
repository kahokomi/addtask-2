class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.create(chat_params)
    redirect_back(fallback_location: root_path)
  end

  private
  
  def chat_params
    params.require(:chat).permit(:user_id, :chats, :room_id).merge(user_id: current_user.id)
  end
end
