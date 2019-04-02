# frozen_string_literal: true
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
  end

  def unsubscribed
  end

  def update_students_counter
  end

  private
  #Counts all users connected to the ActionCable server
  def count_unique_connections
    connected_users = []
    ActionCable.server.connections.each do |connection|
      connected_users.push(1)
    end
    return connected_users.uniq.length
  end
end
