class PlaylistsController < ApplicationController

  before_action :authenticate_user!, :except => [:show]

  def index
    if User.where(:id => params[:user_id]).blank?
      flash[:notice] = "We can't find this user in our database"
      redirect_to root_path
    else
      @user = User.find(params[:user_id])
      @starredplaylist = @user.playlists.where(name: 'Starred tracks')
      @playlists = @user.playlists.map{|playlist| playlist if playlist.name != "Starred tracks"}.compact
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
    if Playlist.where(:id => params[:id]).blank?
      flash[:notice] = "We can't find this playlist in our database"
      redirect_to root_path
    else
      @playlist = Playlist.find(params[:id])
      # @tracks = @playlist.tracks
      if request.xhr? 
        render json: @playlist.to_json(:include => [:tracks, :user])
      else
        render :nothing => true
      end
    end
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

  # def edit
  #   @playlist = Playlist.find(params[:id])
  # end

end
