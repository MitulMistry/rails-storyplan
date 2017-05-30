class CreateStoryGenres < ActiveRecord::Migration[4.2]
  def change
    create_table :story_genres do |t|
      t.integer :story_id
      t.integer :genre_id

      t.timestamps null: false
    end
  end
end
