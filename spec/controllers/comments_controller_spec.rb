require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  shared_examples_for "full access to comment creation and owned comments" do # define @user for these tests
    describe "GET #edit" do
      it "assigns the requested comment to @comment" do
        comment = create(:comment, user: @user)
        get :edit, params: { id: comment }
        expect(assigns(:comment)).to eq comment
      end

      it "renders the :edit template" do
        comment = create(:comment, user: @user)
        get :edit, params: { id: comment }
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      before :each do
        @story = create(:story)
      end

      context "with valid attributes" do
        it "saves the new comment in the database" do
          expect { #proc - evaluates code before and after
            post :create, params: { comment: attributes_for(:comment, story_id: @story.id) } #attributes_for (FactoryBot) creates a params hash, mimicking the hash from a form
          }.to change(Comment, :count).by(1)
        end

        it "assigns current user as owner of the comment" do
          post :create, params: { comment: attributes_for(:comment, story_id: @story.id) }
          expect(Comment.last.user).to eq @user
        end

        it "redirects to stories#show" do
          post :create, params: { comment: attributes_for(:comment, story_id: @story.id) }
          expect(response).to redirect_to story_path(@story)
        end
      end

      context "with invalid attributes" do
        it "does not save the new comment in the database" do
          expect{
            post :create, params: { comment: attributes_for(:invalid_comment, story_id: @story.id) }
          }.not_to change(Comment, :count)
        end

        it "re-renders the story :show template" do
          post :create, params: { comment: attributes_for(:invalid_comment, story_id: @story.id) }
          expect(response).to render_template "stories/show"
        end
      end
    end

    describe "PATCH #update" do
      before :each do #create this story before each test in this describe block
        @story = create(:story)
        @comment = create(:comment, content: "Test comment", story: @story, user: @user)
      end

      context "with valid attributes" do
        it "locates the requested comment" do
          patch :update, params: { id: @comment, comment: attributes_for(:comment) }
          expect(assigns(:comment)).to eq(@comment)
        end

        it "changes the story's attributes" do
          patch :update, params: { id: @comment, comment: attributes_for(:comment, content: "Updated comment") }
          @comment.reload #use reload to check that the changes are actually persisted
          expect(@comment.content).to eq "Updated comment"
        end

        it "redirects to the updated comment's story" do
          patch :update, params: { id: @comment, comment: attributes_for(:comment) }
          expect(response).to redirect_to @story
        end
      end

      context "with invalid attributes" do
        it "does not update the story's attributes" do
          patch :update, params: { id: @comment, comment: attributes_for(:invalid_comment) }
          @comment.reload
          expect(@comment.content).not_to be_nil
        end

        it "re-renders the :edit template" do
          patch :update, params: { id: @comment, comment: attributes_for(:invalid_comment) }
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @story = create(:story)
        @comment = create(:comment, story: @story, user: @user)
      end

      it "deletes the comment from the database" do
        expect {
          delete :destroy, params: { id: @comment }
        }.to change(Comment, :count).by(-1)
      end

      it "redirects to the comment's story" do
        delete :destroy, params: { id: @comment }
        expect(response).to redirect_to @story
      end
    end
  end

  shared_examples_for "no modification access to non-owned comments" do # define @user for these tests
    before :each do
      @user2 = create(:user)
      @story = create(:story)
      @comment = create(:comment, story: @story, user: @user2, content: "Test content")
    end

    describe "GET #edit" do
      it "redirects to stories#index" do
        get :edit, params: { id: @comment }
        expect(response).to redirect_to stories_path
      end
    end

    describe "PATCH #update" do
      it "it does not change the comment's attributes" do
        patch :update, params: { id: @comment, comment: attributes_for(:comment, content: "Updated content") }
        @comment.reload #use reload to check that the changes are actually persisted
        expect(@comment.content).to eq "Test content"
      end

      it "redirects to stories#index" do
        patch :update, params: { id: @comment, comment: attributes_for(:comment) }
        expect(response).to redirect_to stories_path
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the comment from the database" do
        expect {
          delete :destroy, params: { id: @comment }
        }.to_not change(Comment, :count)
      end

      it "redirects to stories#index" do
        delete :destroy, params: { id: @comment }
        expect(response).to redirect_to stories_path
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "full access to comment creation and owned comments"
    it_behaves_like "no modification access to non-owned comments"
  end

  describe "guest access" do
    describe "GET #edit" do
      it "requires login" do
        comment = create(:comment)
        get :edit, params: { id: comment }
        expect(response).to require_login # custom matcher under support/matchers/require_login.rb
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, params: { comment: attributes_for(:comment) }
        expect(response).to require_login
      end
    end

    describe "PUT #update" do
      it "requires login" do
        patch :update, params: { id: create(:comment), comment: attributes_for(:comment) }
        expect(response).to require_login
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, params: { id: create(:comment) }
        expect(response).to require_login
      end
    end
  end
end
