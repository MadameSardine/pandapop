class PlaylistsController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

  def index
    @user = current_user
    @playlists = Playlist.all
  end

  def new
    @user = current_user
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    if @playlist.save
      flash[:notice] = "Playlist successfully created"
      redirect_to playlists_path
    else
      flash[:notice] = "Playlist was not successfully created"
      redirect_to playlists_path
    end
  end

  def playlist_params
    params.require(:playlist).permit(:name, :image)
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

  # def edit
  #   @playlist = Playlist.find(params[:id])
  # end 

end
