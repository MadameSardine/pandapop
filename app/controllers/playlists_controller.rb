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

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    flash[:notice] = "Playlist has been successfully deleted"

    redirect_to root_path
  end

  def update
    @playlist = Playlist.find(params[:id])
    @track = @playlist.tracks.find_by(:title => (params[:title]))
    @playlist.tracks.delete(@track)
    flash[:notice] = "Track successfully removed from playlist"

    redirect_to playlist_path(params[:id])
  end

end
