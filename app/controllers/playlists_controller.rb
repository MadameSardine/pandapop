class PlaylistsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @user = current_user
    @playlist = Playlist.new
  end

  def create
    @user = User.find(params[:user_id])
    @playlist = @user.playlists.new(playlist_params)
    @playlist.user = current_user
    @playlist.save
    redirect_to root_path
  end

  def playlist_params
    params.require(:playlist).permit(:name)
  end

  def show 
  end

end
