class UserSignInCount < ApplicationRecord
  belongs_to :user

  def self.valid_users
    times = all.map(&:created_at)
    times.select{|tim| Time.now.minus_with_coercion(tim.localtime) >= 60 }.count
  end

  def self.chats_time
    last_signin = first.created_at
    Time.now.minus_with_coercion(last_signin.localtime)
  end  
end
