class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :story_id
      t.text :content

      t.timestamps null: false
    end
  end
end
