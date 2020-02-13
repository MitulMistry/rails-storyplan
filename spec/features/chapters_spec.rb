require 'rails_helper'

feature "Chapter management" do
  context "as a user" do
    before :each do
      @user = create(:user, password: "password") #FactoryBot
      sign_in_with_form(@user) #login macro
    end

    scenario "creates chapter through form" do
      story = create(:story, user: @user)
      character = create(:character, user: @user)

      visit root_path #with capybara
      click_link "New Chapter"
      fill_in "chapter_name", with: "Test Name" #fill_in accepts name, id or label text
      fill_in "chapter_objective", with: "Test objective."
      fill_in "chapter_target_word_count", with: "5000"
      choose(id: "chapter_currently_writing_true")
      fill_in "chapter_overview", with: "Test overview."
      check(character.name)

      #nested character creation
      fill_in "chapter_characters_attributes_0_name", with: "Nested Test Character 1"

      expect{
        click_button "Submit"
      }.to change(Chapter, :count).by(1)

      chapter = Chapter.last
      expect(chapter.name).to eq "Test Name"
      expect(chapter.objective).to eq "Test objective."
      expect(chapter.target_word_count).to eq 5000
      expect(chapter.currently_writing).to eq true
      expect(chapter.overview).to eq "Test overview."
      expect(Character.last.name).to eq "Nested Test Character 1"
      expect(chapter.characters.collect(&:name)).to include(character.name, "Nested Test Character 1") #collect all character names

      expect(page).to have_content("Chapter was successfully created.")
    end

    scenario "edits chapter through form" do
      story = create(:story, user: @user)
      chapter = create(:chapter, story: story)
      character = create(:character, user: @user)
      chapter.characters << character

      visit root_path #with capybara
      click_link "Profile"
      click_link chapter.name
      click_link "Edit"
      fill_in "chapter_name", with: "Edited Name" #fill_in accepts name, id or label text
      fill_in "chapter_objective", with: "Edited objective."
      fill_in "chapter_target_word_count", with: "2000"
      choose(id: "chapter_currently_writing_true")
      fill_in "chapter_overview", with: "Edited overview."
      uncheck(character.name)
      click_button "Submit"

      chapter.reload
      expect(chapter.name).to eq "Edited Name"
      expect(chapter.objective).to eq "Edited objective."
      expect(chapter.target_word_count).to eq 2000
      expect(chapter.currently_writing).to eq true
      expect(chapter.overview).to eq "Edited overview."
      expect(chapter.characters).not_to include(character)

      expect(page).to have_content("Chapter was successfully updated.")
    end

    scenario "deletes chapter through button", js: true do #enable selenium-webdriver for js
      story = create(:story, user: @user)
      chapter = create(:chapter, story: story)

      visit root_path #with capybara
      click_link "Profile"
      click_link chapter.name

      expect{
        accept_confirm do #accept js confirmation box w/capybara
          click_link "Delete Chapter"
        end
      }.to change(Chapter, :count).by(-1)

      expect(page).to have_content("Chapter was successfully deleted.")
    end
  end
end
