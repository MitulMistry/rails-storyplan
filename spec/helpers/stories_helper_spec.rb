require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StoriesHelper. For example:
#
# describe StoriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StoriesHelper, type: :helper do
  context "with text over character limit" do
    it "truncates story overview to 150 characters" do
      story = create(:story, overview: Faker::Lorem.characters(number: 175))
      expect(helper.story_truncated_overview(story).length).to eq(150)
    end
  end

  context "with text below character limit" do
    it "doesn't truncate story overview" do
      story = create(:story, overview: Faker::Lorem.characters(number: 100))
      expect(helper.story_truncated_overview(story).length).to eq(100)
    end
  end
end
