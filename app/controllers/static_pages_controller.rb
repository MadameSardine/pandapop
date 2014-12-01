class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player, :test]

	def index
    @key = ENV['youtube_api_key']
		@playlists = Playlist.all 
    if params[:'search-content'] == nil 
      render :'static_pages/welcome'
    else
      q = params[:'search-content'].to_s.gsub(' ', '+') + '+karaoke'
    end
    @json = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=4&q=#{q}&type=video&order=viewCount&key=#{@key}").parsed_response
    @track = Track.new
		@items = @json["items"].collect do |item|
			HTTParty.get("https://www.googleapis.com/youtube/v3/videos?id=#{item["id"]["videoId"]}&key=#{@key}&part=contentDetails,statistics,snippet").parsed_response
		end
	end

  def player
    if params[:videoId] == nil
      redirect_to root_path
    else
      @url = 'http://youtube.com/embed/' + params[:videoId] + '?autoplay=1' #to start on load
    end
    @playlists = Playlist.all
  end

end
