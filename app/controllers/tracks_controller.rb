class TracksController < ApplicationController

  def create
    # @json= HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=4&q=#{params[:q]}&type=video&key=AIzaSyDX1TrCX_GkuuCFBaQHvVDRc24Rq3HL-Sk").parsed_response
    # Track.create(params.permit(:video_id, :view_count))

    @track = Track.create(track_params)

    redirect_to root_path
  end

  def new
  end

  private

  def track_params
    params.require(:track).permit(:title, :video_id)
  end

end
