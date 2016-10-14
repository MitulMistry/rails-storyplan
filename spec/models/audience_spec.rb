require 'rails_helper'

RSpec.describe Audience, type: :model do
  it "has a valid factory" do
    expect(build(:audience)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "required validations" do
    it { should validate_presence_of(:name) } #using shoulda-matchers
  end
end
