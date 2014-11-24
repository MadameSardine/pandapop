class TracksController < ApplicationController

  def index
    @tracks = Track.all
  end

  def update
  	@track = Track.find(params[:id])
  	@track.update(track_params)
  	redirect_to track_path(@track)
  	flash[:notice] = "Track added to playlist"
  end


  def show
  	@track = Track.find(params[:id])
  end

  private

  def track_params
  	params.require(:track).permit(:title, :youtube_url, :duration, :plays, :playlist_id)
  end
end
