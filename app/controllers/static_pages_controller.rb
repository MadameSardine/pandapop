class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player, :test, :get_songs]

	def index
		@playlists = Playlist.all
    @track = Track.new
	end

  def player
    if params[:videoId] == nil
      redirect_to root_path
    else
      @url = 'http://youtube.com/embed/' + params[:videoId] + '?autoplay=1' #to start on load
    end
    @playlists = Playlist.all
  end

	def get_songs
		q = params[:'search-content'].to_s.gsub(' ', '+') + '+karaoke'
		@key = ENV['youtube_api_key']
		@json = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=4&q=#{q}&type=video&order=viewCount&key=#{@key}").parsed_response
		@track = Track.new
		@items = @json["items"].collect do |item|
			HTTParty.get("https://www.googleapis.com/youtube/v3/videos?id=#{item["id"]["videoId"]}&key=#{@key}&part=contentDetails,statistics,snippet").parsed_response
		end
		render json: {:json => @json,
									:items => @items}
	end

end
