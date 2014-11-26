class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :artist_name
      t.string :album_name
      t.string :duration
      t.integer :view_count
      t.integer :like_count
      t.string :video_id
      t.string :video_url

      t.timestamps
    end
  end
end
