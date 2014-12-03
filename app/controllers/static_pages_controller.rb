class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player, :test, :get_songs]
  skip_before_action :verify_authenticity_token

  def index # <-- this method is getting well in need of refactoring :-)
    @key = ENV['youtube_api_key']
    @playlists = Playlist.all
    if params[:'search-content'] == nil
      q = 'panda+karaoke'
    else
      q = params[:'search-content'].to_s.gsub(' ', '+') + '+karaoke'
    end
    @track = Track.new
    if params[:videoId] == nil
      @url = 'http://youtube.com/embed/videoId=hDZbA17QqXU'
    else
      @url = 'http://youtube.com/embed/' + params[:videoId] + '?autoplay=1' #to start on load
      @current_track = HTTParty.get("https://www.googleapis.com/youtube/v3/videos?id=#{params[:videoId]}&vq=hd1080&key=#{@key}&part=snippet").parsed_response
      @current_track_title = @current_track["items"][0]["snippet"]["title"]
    end
  end

	def get_songs
		q = params[:'search-content'].to_s.gsub(' ', '+') + '+karaoke'
		@key = ENV['youtube_api_key']
		@json = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=15&q=#{q}&type=video&order=viewCount&key=#{@key}").parsed_response
		@track = Track.new
		@items = @json["items"].collect do |item|
			HTTParty.get("https://www.googleapis.com/youtube/v3/videos?id=#{item["id"]["videoId"]}&key=#{@key}&part=contentDetails,statistics,snippet").parsed_response
		end
		render json: {:json => @json,
									:items => @items}
	end

end
