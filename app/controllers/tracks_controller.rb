class TracksController < ApplicationController

  load_and_authorize_resource

  before_filter :check_user?, only: [:create, :destroy]

  def create
    @track = Track.create(track_params)
    playlist.tracks << @track
    if request.xhr?
      render json: @track
    else
      redirect_to playlist_path(playlist), notice: 'Track successfully added to playlist'
    end
  end

  def new
    @track = Track.new
    @playlists = Playlist.all
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    render :nothing => true
  end

  private

  def track_params
    params.require(:track).permit(:title, :duration, :video_id)
  end

  def playlist
    @playlist ||= Playlist.find(params[:track][:playlists])
  end

  def check_user?
    if playlist.user != current_user
      redirect_to root_path, notice: 'This is not your playlist'
    end
  end

end
