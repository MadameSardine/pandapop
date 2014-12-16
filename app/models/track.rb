class Track < ActiveRecord::Base

  has_and_belongs_to_many :playlists
  # why is this relationship here? should just be a belongs_to :playlists

end
