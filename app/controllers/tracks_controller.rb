class TracksController < ApplicationController

  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

  def update
  	@track = Track.find(params[:id])
  	@track.update(track_params)
  	redirect_to track_path(@track)
  	flash[:notice] = "Track added to playlist"
  end

  def new 
    @track = Track.new
  end

  protected

  def track_params
  	params.require(:track).permit(:title, :youtube_url, :duration, :plays, :playlist)
  end

end
