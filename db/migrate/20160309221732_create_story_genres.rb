class CreateStoryGenres < ActiveRecord::Migration
  def change
    create_table :story_genres do |t|
      t.integer :story_id
      t.integer :genre_id

      t.timestamps null: false
    end
  end
end
