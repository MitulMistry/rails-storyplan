require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  shared_examples_for "public access to pages" do
    describe "GET #index" do
      it "populates an array of 4 stories" do
        5.times { create(:story) }
        get :index
        expect(assigns(:stories).first).to be_a(Story)
        expect(assigns(:stories).length).to eq 4
      end

      it "populates an array of 4 writers" do
        5.times { create(:user) }
        get :index
        expect(assigns(:writers).first).to be_a(User)
        expect(assigns(:writers).length).to eq 4
      end

      it "populates an array of 4 characters" do
        5.times { create(:character) }
        get :index
        expect(assigns(:characters).first).to be_a(Character)
        expect(assigns(:characters).length).to eq 4
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
