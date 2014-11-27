class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player, :test]

	def index
    q = params[:'search-content'].to_s.gsub(' ', '+') + '+karaoke'
    @json = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=4&q=#{q}&type=video&key=AIzaSyDX1TrCX_GkuuCFBaQHvVDRc24Rq3HL-Sk").parsed_response
    @track = Track.new
    @json["items"].each do |item|
      video_id = item["id"]["videoId"]
      @content_details = HTTParty.get("https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=AIzaSyDX1TrCX_GkuuCFBaQHvVDRc24Rq3HL-Sk&part=contentDetails,statistics").parsed_response
    end
    @playlists = Playlist.all
	end

  def player
    if params[:videoId] == nil
      redirect_to root_path
    else
      puts params[:videoId]
      @url = 'http://youtube.com/embed/' + params[:videoId]
    end
    @playlists = Playlist.all
  end

  def test
    @song = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=4&q=#{params[:q]}&type=video&key=AIzaSyDX1TrCX_GkuuCFBaQHvVDRc24Rq3HL-Sk").parsed_response
  end
end