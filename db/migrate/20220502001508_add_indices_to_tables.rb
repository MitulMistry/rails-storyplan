class AddIndicesToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :chapters, :story_id
    add_index :character_chapters, :character_id
    add_index :character_chapters, :chapter_id
    add_index :characters, :user_id
    add_index :comments, :user_id
    add_index :comments, :story_id
    add_index :stories, :user_id
    add_index :story_audiences, :story_id
    add_index :story_audiences, :audience_id
    add_index :story_genres, :story_id
    add_index :story_genres, :genre_id
    add_index :users, :username
  end
end
