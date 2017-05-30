class AddAttachmentPortraitToCharacters < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :characters, :portrait
  end

  def self.down
    remove_attachment :characters, :portrait
  end
end
