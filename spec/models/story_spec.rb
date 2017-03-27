require 'rails_helper'

RSpec.describe Story, type: :model do
  it "has a valid factory" do
    expect(build(:story)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  it "has an invalid child factory" do
    expect(build(:invalid_story)).to be_invalid
  end

  describe "associations" do
    it { should belong_to(:user) } #using shoulda-matchers
    it { should have_many(:audiences) }
    it { should have_many(:chapters) }
    it { should have_many(:characters) }
    it { should have_many(:comments) }
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:name) }
    end

    context "image (cover) validations" do
      it { should have_attached_file(:cover) }
      it { should validate_attachment_presence(:cover) }
      it { should validate_attachment_content_type(:cover).
        allowing("image/jpeg", "image/jpg", "image/gif", "image/png").
        rejecting("text/plain", "text/xml") }
      it { should validate_attachment_size(:cover).less_than(2.megabytes) }
      #it should validate dimensions (600 x 900?)
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

    it "returns a sorted array of the story's 10 most recent comments (newest first)" do
      user1 = create(:user)
      user2 = create(:user)
      story = create(:story, user: user1)

      comment1 = create(:comment, user: user1, story: story)
      comment2 = create(:comment, user: user2, story: story)
      comment3 = create(:comment, user: user1, story: story)
      comment4 = create(:comment, user: user2, story: story)
      comment5 = create(:comment, user: user1, story: story)
      comment6 = create(:comment, user: user2, story: story)
      comment7 = create(:comment, user: user1, story: story)
      comment8 = create(:comment, user: user2, story: story)
      comment9 = create(:comment, user: user1, story: story)
      comment10 = create(:comment, user: user2, story: story)
      comment11 = create(:comment, user: user1, story: story)

      expect(story.recent_comments).to eq [comment11, comment10, comment9, comment8, comment7, comment6, comment5, comment4, comment3, comment2]
    end
  end

end
