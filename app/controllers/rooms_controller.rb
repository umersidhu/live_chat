# frozen_string_literal: true
class RoomsController < ApplicationController
  def index
    UserSignInCount.create!(user_id: current_user.id) if (current_user.present? && current_user.user_sign_in_count.blank?)
    @rooms = Room.all
    return redirect_to room_path(Room.first) if UserSignInCount.valid_users > 1
  end

  def show
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
    @room = Room.first || Room.create(title: "chat")
    RoomUser.create_or_update!(@room.id, current_user.id, @messages&.last&.id)
    @message = Message.new
    @messages = @room.messages.last(40)
  end

  private

  def room_params
    params.require(:room).permit(:title)
  end
end
