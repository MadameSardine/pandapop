class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player, :test]

	def index
    @key = ENV['youtube_api_key']
		@playlists = Playlist.all
    if params[:'search-content'] == nil
      q = 'panda+karaoke'
    else
      q = params[:'search-content'].to_s.gsub(' ', '+') + '+karaoke'
    end
    @json = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=4&q=#{q}&type=video&order=viewCount&key=#{@key}").parsed_response
    @track = Track.new
		@items = @json["items"].collect do |item|
			HTTParty.get("https://www.googleapis.com/youtube/v3/videos?id=#{item["id"]["videoId"]}&key=#{@key}&part=contentDetails,statistics,snippet").parsed_response
		end
    if params[:videoId] == nil
      @url = 'http://youtube.com/embed/videoId=hDZbA17QqXU?autoplay=1'
    else
      @url = 'http://youtube.com/embed/' + params[:videoId] + '?autoplay=1' #to start on load
    end
  end
end
