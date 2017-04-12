require 'rails_helper'

RSpec.describe WritersController, type: :controller do
  shared_examples_for "public access to writers" do
    describe "GET #index" do
      it "populates an array of writers per page (by creation date)" do
        writer1 = create(:user)
        writer2 = create(:user)
        writer3 = create(:user)
        get :index
        expect(assigns(:writers).first(3)).to eq [writer3, writer2, writer1] # get first 3 in array to test since may or may not include @user (under user access)
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested writer to @writer" do
        writer = create(:user) #FactoryGirl, invoke user factory
        get :show, params: { id: writer } #make a GET request with id for user
        expect(assigns(:writer)).to eq writer #assigns checks value of @story in controller
      end

      it "renders the :show template" do
        get :show, params: { id: create(:user) }
        expect(response).to render_template :show #response is finished product returned from controller
      end
    end
  end

  shared_examples_for "full access to owned writers" do #define @user for these tests
    describe "GET #profile" do
      it "assigns the current user to @writer" do
        get :profile
        expect(assigns(:writer)).to eq @user
      end

      it "renders the :show template" do
        get :profile
        expect(response).to render_template :show
      end
    end

    describe "GET #edit_profile" do
      it "assigns the current user to @writer" do
        get :edit_profile
        expect(assigns(:writer)).to eq @user
      end

      it "renders the :edit_profile template" do
        get :edit_profile
        expect(response).to render_template :edit_profile
      end
    end

    describe "GET #my_stories" do
      it "assigns the current user to @writer" do
        get :my_stories
        expect(assigns(:writer)).to eq @user
      end
    end

    describe "PATCH #update_profile" do
      context "with valid attributes" do
        it "assigns the current user to @writer" do
          patch :update_profile, params: { user: attributes_for(:user) }
          expect(assigns(:writer)).to eq @user
        end

        it "changes the writer's attributes" do
          patch :update_profile, params: { user: attributes_for(:user, bio: "Updated bio") }
          @user.reload #use reload to check that the changes are actually persisted
          expect(@user.bio).to eq "Updated bio"
        end

        it "uploads a new story cover" do
          patch :update_profile, params: { user: attributes_for(:user_with_uploaded_avatar) }
          @user.reload
          expect(@user.avatar.original_filename).to eq "test_user_avatar_400.png"
        end

        it "redirects to the updated profile" do
          patch :update_profile, params: { user: attributes_for(:user) }
          expect(response).to redirect_to profile_path
        end
      end

      context "with invalid attributes" do
        it "does not update the writer's attributes" do
          name = @user.full_name
          patch :update_profile, params: { user: attributes_for(:user, full_name: Faker::Lorem.characters(201)) }
          @user.reload
          expect(@user.full_name).to eq name
        end

        it "re-renders the :edit_profile template" do
          patch :update_profile, params: { user: attributes_for(:invalid_user) }
          expect(response).to render_template :edit_profile
        end
      end
    end

    describe "PATCH #delete_user_avatar" do
      before :each do
        patch :update_profile, params: { user: attributes_for(:user_with_uploaded_avatar) } #upload avatar for current user
        patch :delete_avatar
      end

      it "deletes the writer avatar from the database" do
        @user.reload
        expect(@user.avatar).not_to exist
      end

      it "doesn't delete the writer" do
        @user.reload
        expect(@user).not_to be_nil
      end

      it "redirects to the writer" do
        expect(response).to redirect_to profile_path
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to writers"
    it_behaves_like "full access to owned writers"
  end

  describe "guest access" do
    it_behaves_like "public access to writers"

    describe "GET #profile" do
      it "requires login" do
        get :profile
        expect(response).to require_login # custom matcher under support/matchers/require_login.rb
      end
    end

    describe "GET #edit_profile" do
      it "requires login" do
        get :edit_profile
        expect(response).to require_login
      end
    end

    describe "GET #my_stories" do
      it "requires login" do
        get :my_stories
        expect(response).to require_login
      end
    end

    describe "PATCH #update_profile" do
      it "requires login" do
        patch :update_profile, params: { user: attributes_for(:user) }
        expect(response).to require_login
      end
    end

    describe "PATCH #delete_avatar" do
      it "requires login" do
        patch :delete_avatar, params: { id: create(:user_with_avatar) }
        expect(response).to require_login
      end
    end
  end
end
