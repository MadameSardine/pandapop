class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player]

	def index
	end

  def player
    puts params[:videoId]
    @url = 'http://youtube.com/embed/' + params[:videoId]
  end

end
