class ActiveUserChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'active_user'
  end

  def unsubscribed
  	
  end

  def user_count
  	ActionCable.server.broadcast('active_user', count: UserSignInCount.count)
  end
end