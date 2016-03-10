class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :objective
      t.integer :target_word_count
      t.text :overview
      
      t.integer :story_id

      t.timestamps null: false
    end
  end
end
