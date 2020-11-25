class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @joinCurrentUser = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @joinUser = UserRoom.create(join_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chats = @room.chats.includes(:user).order("created_at asc")
      @chat = Chat.new
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def join_room_params
        params.permit(:user_id, :room_id).merge(room_id: @room.id)
    end
end
