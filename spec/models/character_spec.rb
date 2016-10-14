require 'rails_helper'

RSpec.describe Character, type: :model do
  it "has a valid factory" do
    expect(build(:character)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "required validations" do
    it { should validate_presence_of(:name) } #using shoulda-matchers
    it { should validate_length_of(:name).is_at_most(200) }
    it { should belong_to(:user) }
  end

  describe "other validations" do
    it { should validate_length_of(:bio).is_at_most(4000) }
    it { should validate_length_of(:traits).is_at_most(800) }
  end

  describe "sort" do
    it "returns a sorted array of characters by creation date (newest first)" do
      character1 = create(:character)
      character2 = create(:character)
      character3 = create(:character)

      expect(Character.ordered).to eq [character3, character2, character1]
    end
  end

end
