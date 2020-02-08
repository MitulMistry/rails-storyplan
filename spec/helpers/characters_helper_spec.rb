require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CharactersHelper. For example:
#
# describe CharactersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CharactersHelper, type: :helper do
  context "with text over character limit" do
    it "truncates character objective to 150 characters" do
      character = create(:character, bio: Faker::Lorem.characters(number: 175))
      expect(helper.character_truncated_bio(character).length).to eq(150)
    end

    it "truncates character overview to 80 characters" do
      character = create(:character, traits: Faker::Lorem.characters(number: 100))
      expect(helper.character_truncated_traits(character).length).to eq(80)
    end
  end

  context "with text below character limit" do
    it "doesn't truncate character objective" do
      character = create(:character, bio: Faker::Lorem.characters(number: 100))
      expect(helper.character_truncated_bio(character).length).to eq(100)
    end

    it "doesn't truncate character overview" do
      character = create(:character, traits: Faker::Lorem.characters(number: 50))
      expect(helper.character_truncated_traits(character).length).to eq(50)
    end
  end
end
