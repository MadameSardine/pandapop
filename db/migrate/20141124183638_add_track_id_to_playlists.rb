class AddTrackIdToPlaylists < ActiveRecord::Migration
  def change
    add_reference :playlists, :track, index: true
  end
end
