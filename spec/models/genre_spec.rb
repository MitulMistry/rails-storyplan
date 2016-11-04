require 'rails_helper'

RSpec.describe Genre, type: :model do
  it "has a valid factory" do
    expect(build(:genre)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "associations" do
    it { should have_many(:stories) } #using shoulda-matchers
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(200) }
      it { should validate_presence_of(:description) }
      it { should validate_length_of(:description).is_at_most(1000) }
    end
  end

  describe "sort" do
    it "returns an array of all genres sorted alphabetically" do
      genre1 = create(:genre, name: "Z Genre")
      genre2 = create(:genre, name: "A Genre")
      genre3 = create(:genre, name: "D Genre")
      expect(Genre.alphabetized).to eq [genre2, genre3, genre1]
    end

    it "returns a sorted array of genre's stories by creation date (newest first)" do
      genre = create(:genre)
      story1 = create(:story)
      story2 = create(:story)
      story3 = create(:story)

      genre.stories << story1
      genre.stories << story2
      genre.stories << story3

      expect(genre.ordered_stories).to eq [story3, story2, story1]
    end
  end
end
