require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it "has a valid factory" do
    expect(build(:chapter)).to be_valid #using FactoryBot syntax methods in rails_helper.rb
  end

  describe "associations" do
    it { should belong_to(:story) } #using shoulda-matchers
    it { should have_many(:characters) }
    it { should delegate_method(:user).to(:story) }
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:name) }
      it { should belong_to(:story) }
    end

    context "other validations" do
      it { should validate_length_of(:objective).is_at_most(1000) }
      it { should validate_length_of(:overview).is_at_most(4000) }
      it { should validate_numericality_of(:target_word_count) }
    end
  end

  describe "sort" do
    it "returns a sorted array of chapters by creation date (newest first)" do
      chapter1 = create(:chapter)
      chapter2 = create(:chapter)
      chapter3 = create(:chapter)

      expect(Chapter.ordered).to eq [chapter3, chapter2, chapter1]
    end

    it "returns an array of chapters set to 'currently writing'" do
      chapter1 = create(:chapter, currently_writing: true)
      chapter2 = create(:chapter, currently_writing: true)
      chapter3 = create(:chapter)

      expect(Chapter.currently_writing).to eq [chapter1, chapter2]
    end
  end
end
