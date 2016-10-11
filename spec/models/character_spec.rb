require 'rails_helper'

RSpec.describe Character, type: :model do
  describe "required validations" do
    it "is valid with a name and user_id" do
      character = Character.new(name: 'Bob', user_id: 1)
      expect(character).to be_valid
    end

    it "is invalid without a name" do
      character = Character.new(name: nil, user_id: 1)
      character.valid?
      expect(character.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a user_id" do
      character = Character.new(name: 'Bob', user_id: nil)
      character.valid?
      expect(character.errors[:user_id]).to include("can't be blank")
    end
  end

  describe "bio length" do
    it "is valid with a bio under 4000 characters" do
      pending "implement"
      raise "fail"
    end

    it "is invalid with a bio over 4000 characters" do
      pending "implement"
      raise "fail"
    end
  end

  describe "traits length" do
    it "is valid with traits under 800 characters" do
      pending "implement"
      raise "fail"
    end

    it "is invalid with traits over 800 characters" do
      pending "implement"
      raise "fail"
    end
  end

  describe "sort" do
    it "returns a sorted array of characters by creation date" do
      pending "implement"
      raise "fail"
      #expect(Character.ordered).to eq []
    end
  end

end
