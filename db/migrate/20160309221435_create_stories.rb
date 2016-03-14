class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.integer :target_word_count
      t.text :overview

      t.integer :user_id

      t.timestamps null: false
    end
  end
end
