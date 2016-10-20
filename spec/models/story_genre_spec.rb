require 'rails_helper'

RSpec.describe StoryGenre, type: :model do
  it { should belong_to(:story) } #using shoulda-matchers
  it { should belong_to(:genre) }
end
