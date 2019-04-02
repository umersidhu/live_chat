# frozen_string_literal: true
class RoomsController < ApplicationController
  def index
    sign_in_user
    UserSignInCount.create!(user_id: current_user.id) if (current_user.present? && current_user.user_sign_in_count.blank?)
    @rooms = Room.all
    gon.sign_time = UserSignInCount.time_diffrence(current_user.current_sign_in_at)
    return redirect_to room_path(Room.first) if UserSignInCount.valid_users >= 3
  end

  def show
    gon.chats_time = UserSignInCount.chats_time
    gon.sign_time = UserSignInCount.time_diffrence(current_user.current_sign_in_at) if current_user.present?
    return redirect_to root_path if UserSignInCount.valid_users < 2
    messages
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params.merge(owner_id: current_user.id))
    if @room.save
      RoomUser.create_or_update!(@room.id, current_user.id, nil)
      redirect_to rooms_url, notice: 'Room is created successfully'
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(room_params)
      redirect_to rooms_url, notice: 'Room is updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_url, notice: 'Room is deleted successfully'
  end

  def messages
    if current_user.present?
      @room = Room.first || Room.create(title: "chat")
      RoomUser.create_or_update!(@room.id, current_user.id, @messages&.last&.id)
      @message = Message.new
      @messages = @room.messages.last(40)
    end
  end

  def sign_in_user
    user_id = User.last.present? ? User.last.id : ""
    email = "stranger#{user_id}@gmail.com"
    username = "stranger#{user_id}"
    if current_user.blank?
      user = User.create(email: email, username: username, password: "123456")
      sign_in(user)
    end 
  end

  private

  def room_params
    params.require(:room).permit(:title)
  end
end
