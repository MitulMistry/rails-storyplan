class CreateCharacters < ActiveRecord::Migration[4.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :bio
      t.string :traits

      t.integer :user_id

      t.timestamps null: false
    end
  end
end
