require 'rails_helper'

RSpec.describe Character, type: :model do
  it "is valid with a name and user_id" do
    character = Character.new(
      name: 'Bob',
      user_id: 1
    )
    expect(character).to be_valid
  end

  it "is invalid without a name" do
    character = Character.new(name: nil)
    character.valid?
    expect(character.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a user_id"
  it "is valid with a bio under 4000 characters"
  it "is invalid with a bio over 4000 characters"
  it "is valid with traits under 800 characters"
  it "is invalid with traits over 800 characters"
  it "returns an ordered set of characters by creation date"
end
