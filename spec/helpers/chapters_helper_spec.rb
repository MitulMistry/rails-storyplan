require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ChaptersHelper. For example:
#
# describe ChaptersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ChaptersHelper, type: :helper do
  context "with text over character limit" do
    it "truncates chapter objective to 150 characters" do
      chapter = build(:chapter, objective: Faker::Lorem.characters(number: 175)) #examples don't need to be persisted to database since just testing formatting (so build instead of create)
      expect(helper.chapter_truncated_objective(chapter).length).to eq(150)
    end

    it "truncates chapter overview to 250 characters" do
      chapter = build(:chapter, overview: Faker::Lorem.characters(number: 275))
      expect(helper.chapter_truncated_overview(chapter).length).to eq(250)
    end
  end

  context "with text below character limit" do
    it "doesn't truncate chapter objective" do
      chapter = build(:chapter, objective: Faker::Lorem.characters(number: 100))
      expect(helper.chapter_truncated_objective(chapter).length).to eq(100)
    end

    it "doesn't truncate chapter overview" do
      chapter = build(:chapter, overview: Faker::Lorem.characters(number: 200))
      expect(helper.chapter_truncated_overview(chapter).length).to eq(200)
    end
  end
end
