require 'rails_helper'

RSpec.describe Audience, type: :model do
  it "has a valid factory" do
    expect(build(:audience)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "associations" do
    it { should have_many(:stories) } #using shoulda-matchers
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(200) }
    end
  end

  describe "sort" do
    it "returns a sorted array of audience's stories by creation date (newest first)" do
      audience = create(:audience)
      story1 = create(:story)
      story2 = create(:story)
      story3 = create(:story)

      audience.stories << story1
      audience.stories << story2
      audience.stories << story3

      expect(audience.ordered_stories).to eq [story3, story2, story1]
    end
  end
end
