require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "required validations" do
    it { should validate_presence_of(:username) } #using shoulda-matchers
  end

  describe "other validations" do
  end
end
