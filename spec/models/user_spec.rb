require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "associations" do
    it { should have_many(:stories) }
    it { should have_many(:characters) }
    it { should have_many(:genres) }
    it { should have_many(:chapters) }
    it { should have_many(:comments) }
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:username) } #using shoulda-matchers
      it { should validate_uniqueness_of(:username) }
    end

    context "other validations" do
      it { should validate_length_of(:full_name).is_at_most(200) }
      it { should validate_length_of(:bio).is_at_most(4000) }
    end
  end

  #self_from_omniauth

  describe "sort" do
    it "returns a sorted array of users by creation date (newest first)" do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)

      expect(User.ordered).to eq [user3, user2, user1]
    end

    it "returns an array of user's stories sorted by last updated" do
      pending "implement"
      raise "fail"
    end

    it "returns an array of user's chapters that are currently being written" do
      pending "implement"
      raise "fail"
    end

    it "returns an array of user's three most recently updated stories" do
      pending "implement"
      raise "fail"
    end

    it "returns an array of user's three most recently updated chapters" do
      pending "implement"
      raise "fail"
    end

    it "returns an array of user's three most recently updated characters" do
      pending "implement"
      raise "fail"
    end
  end
end
