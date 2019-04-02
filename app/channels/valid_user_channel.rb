class ValidUserChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'valid_user'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def valid_user_count
    count = UserSignInCount.valid_users
    ActionCable.server.broadcast('valid_user', count: count)
    if UserSignInCount.count > 0
      if UserSignInCount.chats_time.to_i / 60 > 15
        Message.destroy_all
        UserSignInCount.destroy_all
        user_count = User.count
        ActionCable.server.broadcast('valid_user', count: UserSignInCount.valid_users)
      end
    end
  end
end
