class FollowsController < ApplicationController

  # def create
  #   @playlist = Playlist.find(params[:playlist_id])
  #   @follow = @playlist.follows.new
  #   @follow.followerId = current_user.id
  #   @follow.save
  #   raise"#{@playlist.name}"
  #   flash[:notice] = "You are now following #{@playlist.name}"
  #   redirect_to playlist_path(@playlist)
  # end

  def index
    @playlist = Playlist.find(params[:playlist_id])
    @follow = @playlist.follows.new
    @follow.followerId = current_user.id
    @follow.save
    flash[:notice] = "You are now following #{@playlist.name}"
    redirect_to playlist_path(@playlist)
  end
end
