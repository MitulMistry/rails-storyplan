require 'rails_helper'

RSpec.describe Character, type: :model do
  it "has a valid factory" do
    expect(build(:character)).to be_valid #using FactoryBot syntax methods in rails_helper.rb
  end

  it "has an invalid child factory" do
    expect(build(:invalid_character)).to be_invalid
  end

  it "has a valid child factory with portrait image" do
    expect(build(:character_with_portrait)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:user) } #using shoulda-matchers
    it { should have_many(:chapters) }
    it { should have_many(:stories) }
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(200) }
    end

    context "image (portrait) validations" do
      it { should validate_content_type_of(:portrait).allowing("image/png", "image/jpeg", "image/jpg") }
      it { should validate_content_type_of(:portrait).rejecting("text/plain", "text/xml") }
      it { should validate_size_of(:portrait).less_than(2.megabytes) }
    end

    context "other validations" do
      it { should validate_length_of(:bio).is_at_most(4000) }
      it { should validate_length_of(:traits).is_at_most(800) }
    end
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
