class AddColumnsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :text
    add_column :users, :full_name, :string
  end
end
