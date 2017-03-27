require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid #using FactoryGirl syntax methods in rails_helper.rb
  end

  describe "associations" do
    it { should have_many(:stories) } #using shoulda-matchers
    it { should have_many(:characters) }
    it { should have_many(:chapters) }
    it { should have_many(:comments) }
    it { should have_many(:genres) }

    it "has distinct genres" do
      user = create(:user)
      story1 = create(:story, user: user)
      story2 = create(:story, user: user)

      genre1 = create(:genre)
      genre2 = create(:genre)
      story1.genres << genre1
      story2.genres << genre1
      story2.genres << genre2

      expect(user.genres).to eq [genre1, genre2]
    end
  end

  describe "validations" do
    context "required validations" do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }

      it "has an alphanumeric username" do
        expect(build(:user, username: "testUser1")).to be_valid
        expect(build(:user, username: "test-user2")).to be_valid
        expect(build(:user, username: "test_user3")).to be_valid
        expect(build(:user, username: "test user4")).to be_invalid
        expect(build(:user, username: "testUser5$")).to be_invalid
      end
    end

    context "image (avatar) validations" do
      it { should have_attached_file(:avatar) }
      it { should validate_attachment_presence(:avatar) }
      it { should validate_attachment_content_type(:avatar).
        allowing("image/jpeg", "image/jpg", "image/gif", "image/png").
        rejecting("text/plain", "text/xml") }
      it { should validate_attachment_size(:avatar).less_than(1.megabytes) }
      #it should validate dimensions (400 x 400?)
    end

    context "other validations" do
      it { should validate_length_of(:full_name).is_at_most(200) }
      it { should validate_length_of(:bio).is_at_most(4000) }
    end
  end

  describe "sort" do
    it "returns a sorted array of users by creation date (newest first)" do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)

      expect(User.ordered).to eq [user3, user2, user1]
    end

    it "returns an array of user's stories sorted by last updated" do
      user = create(:user)
      story1 = create(:story, user: user)
      story2 = create(:story, user: user)
      story3 = create(:story, user: user)
      story4 = create(:story, user: user)

      story2.name = "updated name"
      story2.save

      expect(user.ordered_updated_stories).to eq [story2, story4, story3, story1]
    end

    it "returns an array of user's chapters that are currently being written" do
      user = create(:user)
      story = create(:story, user: user)

      chapter1 = create(:chapter, story: story, currently_writing: true)
      chapter2 = create(:chapter, story: story, currently_writing: true)
      chapter3 = create(:chapter, story: story)

      expect(user.current_chapters).to eq [chapter1, chapter2]
    end

    it "returns an array of user's three most recently updated stories" do
      user = create(:user)
      story1 = create(:story, user: user)
      story2 = create(:story, user: user)
      story3 = create(:story, user: user)
      story4 = create(:story, user: user)

      story2.name = "updated name"
      story2.save

      expect(user.recent_stories).to eq [story2, story4, story3]
    end

    it "returns an array of user's three most recently updated chapters" do
      user = create(:user)
      story = create(:story, user: user)

      chapter1 = create(:chapter, story: story)
      chapter2 = create(:chapter, story: story)
      chapter3 = create(:chapter, story: story)
      chapter4 = create(:chapter, story: story)

      chapter2.name = "updated name"
      chapter2.save

      expect(user.recent_chapters).to eq [chapter2, chapter4, chapter3]
    end

    it "returns an array of user's three most recently updated characters" do
      user = create(:user)

      character1 = create(:character, user: user)
      character2 = create(:character, user: user)
      character3 = create(:character, user: user)
      character4 = create(:character, user: user)

      character2.name = "updated name"
      character2.save

      expect(user.recent_characters).to eq [character2, character4, character3]
    end
  end

  describe "omniauth" do
    it "creates a new user from omniauth if user does not exist" do
      pending "implement"
      raise "fail"
    end

    it "logs user in from omniauth if user already exists" do
      pending "implement"
      raise "fail"
    end
  end
end
