require 'rails_helper'

feature "Story management" do
  context "as a user" do
    before :each do
      @user = create(:user, password: "password") #FactoryBot
      sign_in_with_form(@user) #login macro
    end

    scenario "creates story through form" do
      audience = create(:audience, name: "Adult")
      genre = create(:genre, name: "Adventure")

      visit root_path #with capybara
      click_link "New Story"
      fill_in "story_name", with: "Test Name" #fill_in accepts name, id or label text
      fill_in "story_target_word_count", with: "90000"
      check("Adult")
      fill_in "story_overview", with: "Test overview."
      page.select "Adventure", from: "story_genre_ids"

      expect{
        click_button "Submit"
      }.to change(Story, :count).by(1)

      story = Story.last
      expect(story.name).to eq "Test Name"
      expect(story.target_word_count).to eq 90000
      expect(story.audiences).to include audience
      expect(story.overview).to eq "Test overview."
      expect(story.genres).to include genre

      expect(page).to have_content("Story was successfully created.")
    end

    scenario "edits story through form" do
      story = create(:story, user: @user)
      audience = create(:audience, name: "Adult")
      genre = create(:genre, name: "Adventure")
      story.audiences << audience
      story.genres << genre

      visit root_path #with capybara
      click_link "My Stories"
      click_link story.name
      click_link "Edit Story"
      fill_in "story_name", with: "Edited Name"
      fill_in "story_target_word_count", with: "50000"
      uncheck("Adult")
      fill_in "story_overview", with: "Edited overview."
      page.unselect "Adventure", from: "story_genre_ids"
      click_button "Submit"

      story.reload
      expect(story.name).to eq "Edited Name"
      expect(story.target_word_count).to eq 50000
      expect(story.audiences).not_to include(audience)
      expect(story.overview).to eq "Edited overview."
      expect(story.genres).not_to include(genre)

      expect(page).to have_content("Story was successfully updated.")
    end

    scenario "deletes story through button", js: true do #enable selenium-webdriver for js
      story = create(:story, user: @user)

      visit root_path #with capybara
      click_link "My Stories"
      click_link story.name

      expect{
        accept_confirm do #accept js confirmation box w/capybara
          click_link "Delete Story"
        end
      }.to change(Story, :count).by(-1)

      expect(page).to have_content("Story was successfully deleted.")
    end
  end
end
