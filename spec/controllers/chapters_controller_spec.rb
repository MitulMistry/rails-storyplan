require 'rails_helper'

RSpec.describe ChaptersController, type: :controller do
  shared_examples_for "public access to chapters" do
    describe "GET #index" do
      it "populates an array of chapters per page (by creation date)" do
        chapter1 = create(:chapter) # FactoryGirl creates the chapter, which creates an associated story, which creates an associated user
        chapter2 = create(:chapter)
        chapter3 = create(:chapter)
        get :index
        expect(assigns(:chapters)).to eq [chapter3, chapter2, chapter1]
      end

      it "populates an array of a writer's chapters per page (by creation date)" do
        user1 = create(:user)
        story1 = create(:story, user: user1)
        user2 = create(:user)
        story2 = create(:story, user: user2)

        chapter1 = create(:chapter, story: story1)
        chapter2 = create(:chapter, story: story2)
        chapter3 = create(:chapter, story: story1)
        get :index, params: { writer_id: user1.id }
        expect(assigns(:chapters)).to eq [chapter3, chapter1]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested chapter to @chapter" do
        chapter = create(:chapter) #FactoryGirl, invoke story factory
        get :show, params: { id: chapter } #make a GET request with id for story
        expect(assigns(:chapter)).to eq chapter #assigns checks value of @story in controller
      end

      it "renders the :show template" do
        get :show, params: { id: create(:chapter) }
        expect(response).to render_template :show #response is finished product returned from controller
      end
    end
  end

  shared_examples_for "full access to chapter creation and owned chapters" do # define @user for these tests
    describe "GET #new" do
      context "if user has at least one story" do
        before :each do
          @story = create(:story, user: @user)
        end

        context "with no nested story route" do
          it "assigns a new Chapter to @chapter" do
            get :new
            expect(assigns(:chapter)).to be_a_new(Chapter)
          end

          it "renders the :new template" do
            get :new
            expect(response).to render_template :new
          end
        end

        context "with nested story route" do
          it "assigns a new Chapter to @chapter" do
            get :new, params: { story_id: @story.id }
            expect(assigns(:chapter)).to be_a_new(Chapter)
          end

          it "associates a new Chapter with story" do
            get :new, params: { story_id: @story.id }
            expect(assigns(:chapter).story_id).to eq @story.id
          end

          it "renders the :new template" do
            get :new, params: { story_id: @story.id }
            expect(response).to render_template :new
          end
        end
      end

      context "if user does not have any stories" do
        it "redirects to stories#new" do
          get :new
          expect(response).to redirect_to new_story_path
        end
      end
    end

    describe "GET #edit" do
      before :each do
        story = create(:story, user: @user)
        @chapter = create(:chapter, story: story)
      end

      it "assigns the requested chapter to @chapter" do
        get :edit, params: { id: @chapter }
        expect(assigns(:chapter)).to eq @chapter
      end

      it "renders the :edit template" do
        get :edit, params: { id: @chapter }
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      before :each do
        @story = create(:story, user: @user)
      end

      context "with valid attributes" do
        it "saves the new chapter in the database" do
          expect { #proc - evaluates code before and after
            post :create, params: { chapter: attributes_for(:chapter, story_id: @story.id) } #attributes_for (FactoryGirl) creates a params hash, mimicking the hash from a form
          }.to change(Chapter, :count).by(1)
        end

        it "assigns current user as owner of the chapter" do
          post :create, params: { chapter: attributes_for(:chapter, story_id: @story.id) }
          expect(Chapter.last.user).to eq @user
        end

        it "redirects to chapters#show" do
          post :create, params: { chapter: attributes_for(:chapter, story_id: @story.id) }
          expect(response).to redirect_to chapter_path(assigns[:chapter]) #the path of @story in controller
        end
      end

      context "with invalid attributes" do
        it "does not save the new chapter in the database" do
          expect {
            post :create, params: { chapter: attributes_for(:invalid_chapter, story_id: @story.id) }
          }.not_to change(Chapter, :count)
        end

        it "re-renders the :new template" do
          post :create, params: { chapter: attributes_for(:invalid_chapter, story_id: @story.id) }
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before :each do #create this chapter before each test in this describe block
        story = create(:story, user: @user)
        @chapter = create(:chapter, name: "Test Chapter", overview: "Test overview", story: story)
      end

      context "with valid attributes" do
        it "locates the requested chapter" do
          patch :update, params: { id: @chapter, chapter: attributes_for(:chapter) }
          expect(assigns(:chapter)).to eq(@chapter)
        end

        it "changes the story's attributes" do
          patch :update, params: { id: @chapter, chapter: attributes_for(:chapter, name: "Updated Chapter") }
          @chapter.reload #use reload to check that the changes are actually persisted
          expect(@chapter.name).to eq "Updated Chapter"
        end

        it "redirects to the updated chapter" do
          patch :update, params: { id: @chapter, chapter: attributes_for(:chapter) }
          expect(response).to redirect_to @chapter
        end
      end

      context "with invalid attributes" do
        it "does not update the chapter's attributes" do
          patch :update, params: { id: @chapter, chapter: attributes_for(:chapter, name: nil, overview: "Updated overview") }
          @chapter.reload
          expect(@chapter.overview).not_to eq "Updated overview"
          expect(@chapter.name).to eq "Test Chapter"
        end

        it "re-renders the :edit template" do
          patch :update, params: { id: @chapter, chapter: attributes_for(:invalid_chapter) }
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        story = create(:story, user: @user)
        @chapter = create(:chapter, story: story)
      end

      it "deletes the chapter from the database" do
        expect{
          delete :destroy, params: { id: @chapter }
        }.to change(Chapter, :count).by(-1)
      end

      it "redirects to writers#my_stories" do
        delete :destroy, params: { id: @chapter }
        expect(response).to redirect_to my_stories_path
      end
    end
  end

  shared_examples_for "no modification access to non-owned chapters" do # define @user for these tests
    before :each do
      @user2 = create(:user)
      @story = create(:story, user: @user2)
      @chapter = create(:chapter, name: "Test Chapter", overview: "Test overview", story: @story)
    end

    describe "GET #new" do
      context "with non-owned nested story" do
        it "redirects to stories#index" do
          create(:story, user: @user) # create a story for user so doesn't redirect due to no user stories
          get :new, params: { story_id: @story.id }
          expect(response).to redirect_to stories_path
        end
      end
    end

    describe "GET #edit" do
      it "redirects to root" do
        get :edit, params: { id: @chapter }
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH #update" do
      it "it does not change the chapter's attributes" do
        patch :update, params: { id: @chapter, chapter: attributes_for(:chapter, name: "Updated Chapter") }
        @chapter.reload #use reload to check that the changes are actually persisted
        expect(@chapter.name).to eq "Test Chapter"
      end

      it "redirects to root" do
        patch :update, params: { id: @chapter, chapter: attributes_for(:chapter) }
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the chapter from the database" do
        expect{
          delete :destroy, params: { id: @chapter }
        }.to_not change(Chapter, :count)
      end

      it "redirects to root" do
        delete :destroy, params: { id: @chapter }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user) # FactoryGirl
      sign_in(@user) # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to chapters"
    it_behaves_like "full access to chapter creation and owned chapters"
    it_behaves_like "no modification access to non-owned chapters"
  end

  describe "guest access" do
    it_behaves_like "public access to chapters"

    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to require_login # custom matcher under support/matchers/require_login.rb
      end
    end

    describe "GET #edit" do
      it "requires login" do
        get :edit, params: { id: create(:chapter) }
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, params: { story: attributes_for(:chapter) }
        expect(response).to require_login
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        patch :update, params: { id: create(:chapter), chapter: attributes_for(:chapter) }
        expect(response).to require_login
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, params: { id: create(:chapter) }
        expect(response).to require_login
      end
    end
  end
end
