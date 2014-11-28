class TracksController < ApplicationController

  def create
    @playlist = Playlist.find(params[:track][:playlists])
    @track = Track.create(track_params)
    @playlist.tracks << @track
    redirect_to root_path, notice: 'Track successfully added to playlist'
  end

  def new
  end

  private

  def track_params
    params.require(:track).permit(:title, :duration, :view_count, :like_count, :video_id)
  end

end
