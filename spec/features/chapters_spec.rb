require 'rails_helper'

feature "Chapter management"
  context "as a user" do
    before :each do
      @user = create(:user, password: "password") #FactoryGirl
      sign_in_with_form(@user) #login macro
    end

    scenario "creates chapter" do
      pending "implement"
      raise "fail"
    end

    scenario "edits chapter" do
      pending "implement"
      raise "fail"
    end

    scenario "deletes chapter" do
      pending "implement"
      raise "fail"
    end
  end
end
