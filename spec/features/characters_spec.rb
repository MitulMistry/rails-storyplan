require 'rails_helper'

feature "Character management" do
  context "as a user" do
    before :each do
      @user = create(:user, password: "password") #FactoryBot
      sign_in_with_form(@user) #login macro
    end

    scenario "creates character through form" do
      story = create(:story, user: @user)
      chapter = create(:chapter, story: story)

      visit root_path #with capybara
      click_link "New Character"
      fill_in "character_name", with: "Test Name" #fill_in accepts name, id or label text
      fill_in "character_traits", with: "Test traits"
      fill_in "character_bio", with: "Test bio."
      check(chapter.name)

      expect{
        click_button "Submit"
      }.to change(Character, :count).by(1)

      character = Character.last
      expect(character.name).to eq "Test Name"
      expect(character.traits).to eq "Test traits"
      expect(character.bio).to eq "Test bio."
      expect(character.chapters).to include(chapter)

      expect(page).to have_content("Character was successfully created.")
    end

    scenario "edits character through form" do
      story = create(:story, user: @user)
      chapter = create(:chapter, story: story)
      character = create(:character, user: @user)
      character.chapters << chapter

      visit root_path #with capybara
      click_link "Profile"
      click_link character.name
      click_link "Edit"
      fill_in "character_name", with: "Edited Name" #fill_in accepts name, id or label text
      fill_in "character_traits", with: "Edited traits"
      fill_in "character_bio", with: "Edited bio."
      uncheck(chapter.name)
      click_button "Submit"

      character.reload
      expect(character.name).to eq "Edited Name"
      expect(character.traits).to eq "Edited traits"
      expect(character.bio).to eq "Edited bio."
      expect(character.chapters).not_to include(chapter)

      expect(page).to have_content("Character was successfully updated.")
    end

    scenario "deletes character through button", js: true do #enable selenium-webdriver for js
      character = create(:character, user: @user)
      
      visit root_path #with capybara
      click_link "Profile"
      click_link character.name

      expect{
        accept_confirm do #accept js confirmation box w/capybara
          click_link "Delete Character"
        end
      }.to change(Character, :count).by(-1)

      expect(page).to have_content("Character was successfully deleted.")
    end
  end
end
