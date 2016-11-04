require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  shared_examples_for "public access to genres" do
    describe "GET #index" do
      it "populates an array of all genres" do
        genre1 = create(:genre)
        genre2 = create(:genre)
        genre3 = create(:genre)
        get :index
        expect(assigns(:genres)).to match_array([genre1, genre2, genre3])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      before :each do
        @genre = create(:genre) # FactoryGirl, invoke genre factory
      end

      it "assigns the requested genre to @genre" do
        get :show, id: @genre # make a GET request with id for genre
        expect(assigns(:genre)).to eq @genre # assigns checks value of @genre in controller
      end

      it "populates an array of the genre's stories per page (by creation date)" do
        story1 = create(:story)
        story2 = create(:story)
        story3 = create(:story)

        @genre.stories << story1
        @genre.stories << story3

        get :show, id: @genre
        expect(assigns(:genre_stories)).to match_array([story3, story1])
      end

      it "renders the :show template" do
        get :show, id: @genre
        expect(response).to render_template :show # response is finished product returned from controller
      end
    end
  end

  describe "user access" do
    before :each do
        @user = create(:user)
        sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to genres"
  end

  describe "guest access" do
    it_behaves_like "public access to genres"
  end
end
