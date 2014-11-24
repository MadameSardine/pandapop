class AddLastnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
  end
end
