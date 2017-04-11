require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  shared_examples_for "public access to pages" do
    describe "GET #index" do
      it "populates an array of 3 stories" do
        4.times { create(:story) }
        get :index
        expect(assigns(:stories).length).to eq 3
      end

      it "populates an array of 3 writers" do
        4.times { create(:user) }
        get :index
        expect(assigns(:writers).length).to eq 3
      end

      it "populates an array of 3 characters" do
        4.times { create(:character) }
        get :index
        expect(assigns(:characters).length).to eq 3
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "user access" do
    before :each do
        @user = create(:user)
        sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to pages"
  end

  describe "guest access" do
    it_behaves_like "public access to pages"
  end
end