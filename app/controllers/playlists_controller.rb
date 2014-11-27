class PlaylistsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @user = current_user
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    @playlist.save
    redirect_to root_path
  end

  def playlist_params
    params.require(:playlist).permit(:name)
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def edit
  end

end
