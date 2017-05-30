class AddAttachmentCoverToStories < ActiveRecord::Migration[5.0]
  def self.up
    add_attachment :stories, :cover
  end

  def self.down
    remove_attachment :stories, :cover
  end
end
