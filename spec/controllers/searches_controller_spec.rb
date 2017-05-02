require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  shared_examples_for "public access to searches" do
    describe "GET #search" do
      before :each do
        @story1 = create(:story, name: "Power") # FactoryGirl, invoke story factory
        @story2 = create(:story, name: "Renegades")
        @story3 = create(:story, name: "Renegades 2")

        @character1 = create(:character, name: "Stephanie")
        @character2 = create(:character, name: "Ralphie Howard")
        @character3 = create(:character, name: "Murphy Howard")

        @writer1 = create(:user, username: "targa123", full_name: "Sonny James")
        @writer2 = create(:user, username: "Jax_road", full_name: "Bob Smith")
        @writer3 = create(:user, username: "toga_road", full_name: "Jen Smith")
      end

      it "finds a story by name" do
        get :search, params: { search: "Power" }
        expect(assigns(:items)).to include(@story1)
        expect(assigns(:items)).not_to include(@story2, @story3)

        get :search, params: { search: "renegades" }
        expect(assigns(:items)).to include(@story2, @story3)
        expect(assigns(:items)).not_to include(@story1)
      end

      it "finds a character by name" do
        get :search, params: { search: "Stephanie" }
        expect(assigns(:items)).to include(@character1)
        expect(assigns(:items)).not_to include(@character2, @character3)

        get :search, params: { search: "howard" }
        expect(assigns(:items)).to include(@character2, @character3)
        expect(assigns(:items)).not_to include(@character1)
      end

      it "finds a writer by username" do
        get :search, params: { search: "targa123" }
        expect(assigns(:items)).to include(@writer1)
        expect(assigns(:items)).not_to include(@writer2, @writer3)

        get :search, params: { search: "road" }
        expect(assigns(:items)).to include(@writer2, @writer3)
        expect(assigns(:items)).not_to include(@writer1)
      end

      it "finds a writer by full name" do
        get :search, params: { search: "Sonny" }
        expect(assigns(:items)).to include(@writer1)
        expect(assigns(:items)).not_to include(@writer2, @writer3)

        get :search, params: { search: "smith" }
        expect(assigns(:items)).to include(@writer2, @writer3)
        expect(assigns(:items)).not_to include(@writer1)
      end

      it "finds mixed results" do
        get :search, params: { search: "power stephanie" }
        expect(assigns(:items)).to include(@story1, @character1)
      end

      it "renders the :search template" do
        get :search, params: { search: "item" }
        expect(response).to render_template :search # response is finished product returned from controller
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to searches"
  end

  describe "guest access" do
    it_behaves_like "public access to searches"
  end
end
