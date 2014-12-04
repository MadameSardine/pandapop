class UsersController < ApplicationController

  def index
    if params[:search]
      @user = User.find_by username: params[:search]
    else
      @users = User.all
    end
    render 'show'
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @following = @user.followed_users
    render 'show'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @followers = @user.followers
    render 'show'
  end

end
