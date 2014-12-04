class TracksController < ApplicationController

  load_and_authorize_resource

  def create
    @playlist = Playlist.find(params[:track][:playlists])
    if @playlist.user_id == current_user.id
      @track = Track.create(track_params)
      @playlist.tracks << @track
      if request.xhr? 
        render json: @track
      else
        redirect_to playlist_path(@playlist), notice: 'Track successfully added to playlist'
      end
    else
      redirect_to root_path, notice: 'This is not your playlist'
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
    params.require(:track).permit(:title, :duration, :view_count, :like_count, :video_id)
  end

end
