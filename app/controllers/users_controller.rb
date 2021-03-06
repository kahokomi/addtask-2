class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
      if user_signed_in?
        @currentUserRoom = UserRoom.where(user_id: current_user.id)
        @userUserRoom = UserRoom.where(user_id: @user.id)
        unless @user.id == current_user.id
          @currentUserRoom.each do |cu|
            @userUserRoom.each do |u|
              if cu.room_id == u.room_id
                @haveRoom = true
                @roomId = cu.room_id
              end
            end
          end
          unless @haveRoom
            @room = Room.new
            @user_room = UserRoom.new
          end
        end
      end

    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else @books = @user.books
      render :edit
    end
  end

  def follows
    @user = User.find_by(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end