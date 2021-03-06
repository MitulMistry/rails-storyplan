require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "has a valid factory" do
    expect(build(:comment)).to be_valid #using FactoryBot syntax methods in rails_helper.rb
  end

  it "has an invalid child factory" do
    expect(build(:invalid_comment)).to be_invalid
  end

  describe "associations" do
    it { should belong_to(:user) } #using shoulda-matchers
    it { should belong_to(:story) }
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:content) }
      it { should validate_length_of(:content).is_at_most(1000) }
    end
  end
end
