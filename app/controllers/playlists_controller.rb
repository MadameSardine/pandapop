class PlaylistsController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

  def index
    if User.where(:id => params[:user_id]).blank?
      flash[:notice] = "We can't find this user in our database"
      redirect_to root_path
    else
      @user = User.find(params[:user_id])
    end
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
    else
      flash[:notice] = "Playlist was not successfully created"
    end
    redirect_to user_playlists_path(current_user)
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
    redirect_to user_playlist_path(current_user, params[:id])
  end

end
