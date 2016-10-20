require 'rails_helper'

RSpec.describe StoryAudience, type: :model do
  describe "associations" do
    it { should belong_to(:story) } #using shoulda-matchers
    it { should belong_to(:audience) }
  end
end
