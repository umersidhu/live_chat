class UserSignInCount < ApplicationRecord
  belongs_to :user

  def self.valid_users
    times = all.map(&:created_at)
    times.select{|tim| Time.now.minus_with_coercion(tim.localtime) >= 60 }.count
  end

  def self.chats_time
    return if first.blank?
    last_signin = first.created_at
    time_diffrence(last_signin)
  end  

  def self.time_diffrence time
  	Time.now.minus_with_coercion(time.localtime).to_i
  end
end
