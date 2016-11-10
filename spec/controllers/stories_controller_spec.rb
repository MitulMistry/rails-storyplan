require 'rails_helper'

RSpec.describe StoriesController, type: :controller do

  # kaminari page

  shared_examples_for "public access to stories" do
    describe "GET #index" do
      it "populates an array of stories per page (by creation date)" do
        story1 = create(:story)
        story2 = create(:story)
        story3 = create(:story)
        get :index
        expect(assigns(:stories)).to eq [story3, story2, story1]
      end

      it "populates an array of a writer's stories per page (by creation date)" do
        user = create(:user)
        story1 = create(:story, user: user)
        story2 = create(:story)
        story3 = create(:story, user: user)
        get :index, writer_id: user.id
        expect(assigns(:stories)).to eq [story3, story1]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested story to @story" do
        story = create(:story) #FactoryGirl, invoke story factory
        get :show, id: story #make a GET request with id for story
        expect(assigns(:story)).to eq story #assigns checks value of @story in controller
      end

      it "renders the :show template" do
        story = create(:story)
        get :show, id: story
        expect(response).to render_template :show #response is finished product returned from controller
      end
    end
  end

  shared_examples_for "full access to owned stories" do #define @user for these tests
    describe "GET #new" do
      it "assigns a new Story to @story" do
        get :new
        expect(assigns(:story)).to be_a_new(Story)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "assigns the requested story to @story" do
        story = create(:story, user: @user)
        get :edit, id: story
        expect(assigns(:story)).to eq story
      end

      it "renders the :edit template" do
        story = create(:story, user: @user)
        get :edit, id: story
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new story in the database" do
          expect{ #proc - evaluates code before and after
            post :create, story: attributes_for(:story) #attributes_for (FactoryGirl) creates a params hash, mimicking the hash from a form
          }.to change(Story, :count).by(1)
        end

        it "assigns current user as owner of the story" do
          post :create, story: attributes_for(:story)
          expect(Story.last.user).to eq @user
        end

        it "redirects to stories#show" do
          post :create, story: attributes_for(:story)
          expect(response).to redirect_to story_path(assigns[:story]) #the path of @story in controller
        end
      end

      context "with invalid attributes" do
        it "does not save the new story in the database" do
          expect{
            post :create, story: attributes_for(:invalid_story)
          }.not_to change(Story, :count)
        end

        it "re-renders the :new template" do
          post :create, story: attributes_for(:invalid_story)
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before :each do #create this story before each test in this describe block
          @story = create(:story, name: "Test Story", overview: "Test overview", user: @user)
      end

      context "with valid attributes" do
        it "locates the requested story" do
          patch :update, id: @story, story: attributes_for(:story)
          expect(assigns(:story)).to eq(@story)
        end

        it "changes the story's attributes" do
          patch :update, id: @story, story: attributes_for(:story, name: "Updated Story")
          @story.reload #use reload to check that the changes are actually persisted
          expect(@story.name).to eq "Updated Story"
        end

        it "redirects to the updated story" do
          patch :update, id: @story, story: attributes_for(:story)
          expect(response).to redirect_to @story
        end
      end

      context "with invalid attributes" do
        it "does not update the story's attributes" do
          patch :update, id: @story, story: attributes_for(:story, name: nil, overview: "Updated overview")
          @story.reload
          expect(@story.overview).not_to eq "Updated overview"
          expect(@story.name).to eq "Test Story"
        end

        it "re-renders the :edit template" do
          patch :update, id: @story, story: attributes_for(:invalid_story)
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @story = create(:story, user: @user)
      end

      it "deletes the story from the database" do
        expect{
          delete :destroy, id: @story
        }.to change(Story, :count).by(-1)
      end

      it "deletes associated chapters from the database" do
        @story.chapters << create(:chapter)
        @story.chapters << create(:chapter)
        expect{
          delete :destroy, id: @story
        }.to change(Chapter, :count).by(-2)
      end

      it "redirects to writers#my_stories" do
        delete :destroy, id: @story
        expect(response).to redirect_to my_stories_url
      end
    end
  end

  shared_examples_for "no modification access to non-owned stories" do #define @user for these tests
    before :each do
      @user2 = create(:user)
      @story = create(:story, name: "Test Story", overview: "Test overview", user: @user2)
    end

    describe "GET #edit" do
      it "redirects to stories#index" do
        get :edit, id: @story
        expect(response).to redirect_to stories_path
      end
    end

    describe "PATCH #update" do
      it "it does not change the story's attributes" do
        patch :update, id: @story, story: attributes_for(:story, name: "Updated Story")
        @story.reload #use reload to check that the changes are actually persisted
        expect(@story.name).to eq "Test Story"
      end

      it "redirects to stories#index" do
        patch :update, id: @story, story: attributes_for(:story)
        expect(response).to redirect_to stories_path
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the story from the database" do
        expect{
          delete :destroy, id: @story
        }.to_not change(Story, :count)
      end

      it "does not delete associated chapters from the database" do
        @story.chapters << create(:chapter)
        @story.chapters << create(:chapter)
        expect{
          delete :destroy, id: @story
        }.to_not change(Chapter, :count)
      end

      it "redirects to stories#index" do
        delete :destroy, id: @story
        expect(response).to redirect_to stories_path
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to stories"
    it_behaves_like "full access to owned stories"
    it_behaves_like "no modification access to non-owned stories"
  end

  describe "guest access" do
    it_behaves_like "public access to stories"

    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to require_login # custom matcher under support/matchers/require_login.rb
      end
    end

    describe "GET #edit" do
      it "requires login" do
        story = create(:story)
        get :edit, id: story
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, story: attributes_for(:story)
        expect(response).to require_login
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        patch :update, id: create(:story), story: attributes_for(:story)
        expect(response).to require_login
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, id: create(:story)
        expect(response).to require_login
      end
    end
  end
end
