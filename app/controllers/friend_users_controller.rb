class FriendUsersController < ApplicationController
  def create
    user_to_friend = find_user
    current_user.request_friendship(user_to_friend)
    redirect_to user_to_friend
  end

  private
  
  def find_user
    @_user ||= User.find(params[:id])
  end
end