require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it "has a valid factory" do
    expect(build(:chapter)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "required validations" do
    it { should validate_presence_of(:name) } #using shoulda-matchers
    it { should belong_to(:story) }
  end

  describe "other validations" do
  end
end
