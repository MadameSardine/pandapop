class AddUserToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :followerId, :integer
  end
end
