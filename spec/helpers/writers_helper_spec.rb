require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WritersHelper. For example:
#
# describe WritersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WritersHelper, type: :helper do
  context "with text over character limit" do
    it "truncates writer bio to 150 characters" do
      writer = create(:user, bio: Faker::Lorem.characters(175))
      expect(helper.writer_truncated_bio(writer).length).to eq(150)
    end
  end

  context "with text below character limit" do
    it "doesn't truncate writer bio" do
      writer = create(:user, bio: Faker::Lorem.characters(100))
      expect(helper.writer_truncated_bio(writer).length).to eq(100)
    end
  end
end
