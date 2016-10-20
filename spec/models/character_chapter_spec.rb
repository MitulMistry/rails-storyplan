require 'rails_helper'

RSpec.describe CharacterChapter, type: :model do
  describe "associations" do
    it { should belong_to(:character) } #using shoulda-matchers
    it { should belong_to(:chapter) }
  end
end
