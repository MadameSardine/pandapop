class StaticPagesController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :player]

	def index
	end

  def player
  end

end
