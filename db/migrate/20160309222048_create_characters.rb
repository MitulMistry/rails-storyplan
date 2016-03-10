class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.text :bio
      t.string :traits

      t.timestamps null: false
    end
  end
end
