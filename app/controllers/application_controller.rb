# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  ActionCable.server.broadcast('active_user', count: UserSignInCount.count)
  ActionCable.server.broadcast('valid_user', count: UserSignInCount.valid_users)
end
