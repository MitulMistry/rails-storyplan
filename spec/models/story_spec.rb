require 'rails_helper'

RSpec.describe Story, type: :model do
  it "has a valid factory" do
    expect(build(:story)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:audiences) }
    it { should have_many(:chapters) }
    it { should have_many(:characters) }
    it { should have_many(:comments) }
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:name) } #using shoulda-matchers
    end

    context "other validations" do
      it { should validate_numericality_of(:target_word_count) }
      it { should validate_length_of(:overview).is_at_most(4000) }
    end
  end

  describe "sort" do
    it "returns a sorted array of stories by creation date (newest first)" do
      story1 = create(:story)
      story2 = create(:story)
      story3 = create(:story)

      expect(Story.ordered).to eq [story3, story2, story1]
    end

    it "returns a sorted array of the story's 10 most recent comment (newest first)" do
      pending "implement"
      raise "fail"
      #expect(story.recent_comments).to eq [......]
    end
  end

end
