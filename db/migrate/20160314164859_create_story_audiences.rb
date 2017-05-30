class CreateStoryAudiences < ActiveRecord::Migration[4.2]
  def change
    create_table :story_audiences do |t|
      t.integer :story_id
      t.integer :audience_id

      t.timestamps null: false
    end
  end
end
