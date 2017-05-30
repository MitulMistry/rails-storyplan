class CreateChapters < ActiveRecord::Migration[4.2]
  def change
    create_table :chapters do |t|
      t.string :name
      t.integer :ch_number
      t.string :objective
      t.integer :target_word_count
      t.text :overview
      t.boolean :currently_writing, default: false

      t.integer :story_id

      t.timestamps null: false
    end
  end
end
