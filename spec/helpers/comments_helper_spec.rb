require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CommentsHelper. For example:
#
# describe CommentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe CommentsHelper, type: :helper do
  it "provides readable date" do
    date_time = DateTime.parse("3rd Feb 2001 04:05:06+03:30")
    expect(helper.readable_date(date_time)).to eq("Saturday, Feb 03, 2001")
  end
end
