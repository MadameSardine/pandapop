class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.belongs_to :playlist, index: true

      t.timestamps
    end
  end
end
