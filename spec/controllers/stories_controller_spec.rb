require 'rails_helper'

RSpec.describe StoriesController, type: :controller do

  # kaminari page
  # devise authentication
  # authorize_ownership

  describe "GET #index" do
    it "populates an array of stories per page (by creation date)" do
      story1 = create(:story)
      story2 = create(:story)
      story3 = create(:story)
      get :index
      expect(assigns(:stories)).to match_array([story3, story2, story1])
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
      story = create(:story)
      get :edit, id: story
      expect(assigns(:story)).to eq story
    end

    it "renders the :edit template" do
      story = create(:story)
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
        @story = create(:story, name: "Test Story", overview: "Test overview")
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
      @story = create(:story)
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
