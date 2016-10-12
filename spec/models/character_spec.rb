require 'rails_helper'

RSpec.describe Character, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:character)).to be_valid
  end

  describe "required validations" do
    it "is valid with a name and user_id" do
      character = FactoryGirl.build(:character, name: 'Bob', user_id: 1)
      expect(character).to be_valid
    end

    it "is invalid without a name" do
      character = FactoryGirl.build(:character, name: nil)
      character.valid?
      expect(character.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a user_id" do
      character = FactoryGirl.build(:character, user_id: nil)
      character.valid?
      expect(character.errors[:user_id]).to include("can't be blank")
    end
  end

  describe "bio length" do
    it "is valid with a bio under 4000 characters" do
      character = FactoryGirl.build(:character, bio: Faker::Lorem.characters(3999))
      expect(character).to be_valid
    end

    it "is invalid with a bio over 4000 characters" do
      character = FactoryGirl.build(:character, bio: Faker::Lorem.characters(4001))
      character.valid?
      expect(character.errors[:bio]).to include("is too long (maximum is 4000 characters)")
    end
  end

  describe "traits length" do
    it "is valid with traits under 800 characters" do
      character = FactoryGirl.build(:character, traits: Faker::Lorem.characters(799))
      expect(character).to be_valid
    end

    it "is invalid with traits over 800 characters" do
      character = FactoryGirl.build(:character, traits: Faker::Lorem.characters(801))
      character.valid?
      expect(character.errors[:traits]).to include("is too long (maximum is 800 characters)")
    end
  end

  describe "sort" do
    it "returns a sorted array of characters by creation date (newest first)" do
      character1 = FactoryGirl.create(:character)
      character2 = FactoryGirl.create(:character)
      character3 = FactoryGirl.create(:character)

      expect(Character.ordered).to eq [character3, character2, character1]
    end
  end

end
