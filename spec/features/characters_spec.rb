require 'rails_helper'

feature "Character management"
  context "as a user" do
    before :each do
      @user = create(:user, password: "password") #FactoryGirl
      sign_in_with_form(@user) #login macro
    end

    scenario "creates character" do
      pending "implement"
      raise "fail"
    end

    scenario "edits character" do
      pending "implement"
      raise "fail"
    end

    scenario "deletes character" do
      pending "implement"
      raise "fail"
    end
  end
end
