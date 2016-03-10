class CreateCharacterChapters < ActiveRecord::Migration
  def change
    create_table :character_chapters do |t|
      t.integer :character_id
      t.integer :chapter_id

      t.timestamps null: false
    end
  end
end
