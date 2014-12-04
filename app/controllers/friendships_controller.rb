class FriendshipsController < ApplicationController

  before_filter :authenticate

  def create
    @user = User.find(params[:friendship][:followed_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Friendship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end

end
