require 'rails_helper'

feature "User management" do
  context "as a user" do
    before :each do
      @user = create(:user, password: "password") #FactoryBot
      sign_in_with_form(@user) #login macro
    end

    scenario "edits profile" do
      visit root_path #with capybara
      click_link "Edit Profile"
      fill_in "user_full_name", with: "Test Name" #fill_in accepts name, id or label text
      fill_in "user_bio", with: "Test bio"
      click_button "Submit"

      @user.reload
      expect(@user.full_name).to eq "Test Name"
      expect(@user.bio).to eq "Test bio"

      expect(page).to have_content("Profile was successfully updated.")
    end

    scenario "edits user settings" do
      visit root_path
      click_link "User Settings"
      fill_in "user_email", with: "test@email.com"
      fill_in "user_username", with: "username1234"
      fill_in "user_current_password", with: "password"
      click_button "Update"

      @user.reload
      expect(@user.email).to eq "test@email.com"
      expect(@user.username).to eq "username1234"

      expect(page).to have_content("Your account has been updated successfully.")
    end
  end

  context "as a guest" do
    scenario "creates a new user account" do
      visit root_path
      click_link "Sign up"
      fill_in "user_email", with: "test@email.com"
      fill_in "user_username", with: "username1234"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"

      expect{ #expect user creation
        click_button "Sign up"
      }.to change(User, :count).by(1)

      expect(page).to have_content "Welcome! You have signed up successfully."
    end

    scenario "logs in to user account" do
      user = create(:user) #FactoryBot
      sign_in_with_form(user) #login macro
      expect(page).to have_content "Signed in successfully"
    end
  end
end
