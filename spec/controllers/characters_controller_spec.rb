require 'rails_helper'

RSpec.describe CharactersController, type: :controller do

  shared_examples_for "public access to characters" do
    describe "GET #index" do
      it "populates an array of characters per page (by creation date)" do
        character1 = create(:character)
        character2 = create(:character)
        character3 = create(:character)
        get :index
        expect(assigns(:characters)).to eq [character3, character2, character1]
      end

      it "populates an array of a writer's characters per page (by creation date)" do
        user = create(:user)
        character1 = create(:character, user: user)
        character2 = create(:character)
        character3 = create(:character, user: user)
        get :index, params: { writer_id: user.id }
        expect(assigns(:characters)).to eq [character3, character1]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested character to @character" do
        character = create(:character) #FactoryBot, invoke story factory
        get :show, params: { id: character } #make a GET request with id for story
        expect(assigns(:character)).to eq character #assigns checks value of @story in controller
      end

      it "renders the :show template" do
        get :show, params: { id: create(:character) }
        expect(response).to render_template :show #response is finished product returned from controller
      end
    end
  end

  shared_examples_for "full access to character creation and owned characters" do #define @user for these tests
    describe "GET #new" do
      it "assigns a new Character to @character" do
        get :new
        expect(assigns(:character)).to be_a_new(Character)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "GET #edit" do
      it "assigns the requested character to @character" do
        character = create(:character, user: @user)
        get :edit, params: { id: character }
        expect(assigns(:character)).to eq character
      end

      it "renders the :edit template" do
        character = create(:character, user: @user)
        get :edit, params: { id: character }
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new character in the database" do
          expect { #proc - evaluates code before and after
            post :create, params: { character: attributes_for(:character) } #attributes_for (FactoryBot) creates a params hash, mimicking the hash from a form
          }.to change(Character, :count).by(1)
        end

        it "saves the new character with uploaded portrait in the database" do
          expect { #proc - evaluates code before and after
            post :create, params: { character: attributes_for(:character_with_uploaded_portrait) } #attributes_for (FactoryBot) creates a params hash, mimicking the hash from a form
          }.to change(Character, :count).by(1)

          expect(Character.last.portrait.original_filename).to eq "test_character_portrait_400.png"
        end

        it "assigns current user as owner of the character" do
          post :create, params: { character: attributes_for(:character) }
          expect(Character.last.user).to eq @user
        end

        it "redirects to stories#show" do
          post :create, params: { character: attributes_for(:character) }
          expect(response).to redirect_to character_path(assigns[:character]) #the path of @story in controller
        end
      end

      context "with invalid attributes" do
        it "does not save the new character in the database" do
          expect {
            post :create, params: { character: attributes_for(:invalid_character) }
          }.not_to change(Character, :count)
        end

        it "re-renders the :new template" do
          post :create, params: { character: attributes_for(:invalid_character) }
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before :each do #create this story before each test in this describe block
          @character = create(:character, name: "Test Name", bio: "Test bio", user: @user)
      end

      context "with valid attributes" do
        it "locates the requested character" do
          patch :update, params: { id: @character, character: attributes_for(:character) }
          expect(assigns(:character)).to eq(@character)
        end

        it "changes the story's attributes" do
          patch :update, params: { id: @character, character: attributes_for(:character, name: "Updated Name") }
          @character.reload #use reload to check that the changes are actually persisted
          expect(@character.name).to eq "Updated Name"
        end

        it "uploads a new character portrait" do
          patch :update, params: { id: @character, character: attributes_for(:character_with_uploaded_portrait) }
          @character.reload
          expect(Character.last.portrait.original_filename).to eq "test_character_portrait_400.png"
        end

        it "redirects to the updated character" do
          patch :update, params: { id: @character, character: attributes_for(:character) }
          expect(response).to redirect_to @character
        end
      end

      context "with invalid attributes" do
        it "does not update the character's attributes" do
          patch :update, params: { id: @character, character: attributes_for(:character, name: nil, bio: "Updated bio") }
          @character.reload
          expect(@character.bio).not_to eq "Updated bio"
          expect(@character.name).to eq "Test Name"
        end

        it "re-renders the :edit template" do
          patch :update, params: { id: @character, character: attributes_for(:invalid_character) }
          expect(response).to render_template :edit
        end
      end
    end

    describe "PATCH #delete_character_portrait" do
      before :each do
        @character = create(:character_with_portrait, user: @user)
        patch :delete_portrait, params: { id: @character }
      end

      it "deletes the character portrait from the database" do
        @character.reload
        expect(@character.portrait).not_to exist
      end

      it "doesn't delete the character" do
        @character.reload
        expect(@character).not_to be_nil
      end

      it "redirects to the character" do
        expect(response).to redirect_to @character
      end
    end

    describe "DELETE #destroy" do
      before :each do
        @character = create(:character, user: @user)
      end

      it "deletes the story from the database" do
        expect {
          delete :destroy, params: { id: @character }
        }.to change(Character, :count).by(-1)
      end

      it "redirects to writers#my_stories" do
        delete :destroy, params: { id: @character }
        expect(response).to redirect_to my_stories_url
      end
    end
  end

  shared_examples_for "no modification access to non-owned characters" do
    before :each do
      @user2 = create(:user)
      @character = create(:character, name: "Test Name", bio: "Test bio", user: @user2)
    end

    describe "GET #edit" do
      it "redirects to characters#index" do
        get :edit, params: { id: @character }
        expect(response).to redirect_to characters_path
      end
    end

    describe "PATCH #update" do
      it "it does not change the character's attributes" do
        patch :update, params: { id: @character, character: attributes_for(:character, name: "Updated Name") }
        @character.reload #use reload to check that the changes are actually persisted
        expect(@character.name).to eq "Test Name"
      end

      it "redirects to characters#index" do
        patch :update, params: { id: @character, character: attributes_for(:character) }
        expect(response).to redirect_to characters_path
      end
    end

    describe "PATCH #delete_character_portrait" do
      it "does not delete the character portrait from the database" do
        character = create(:character_with_portrait, user: @user2)
        patch :delete_portrait, params: { id: character }
        expect(character.portrait).to exist
      end
    end

    describe "DELETE #destroy" do
      it "does not delete the character from the database" do
        expect {
          delete :destroy, params: { id: @character }
        }.to_not change(Character, :count)
      end

      it "redirects to characters#index" do
        delete :destroy, params: { id: @character }
        expect(response).to redirect_to characters_path
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to characters"
    it_behaves_like "full access to character creation and owned characters"
    it_behaves_like "no modification access to non-owned characters"
  end

  describe "guest access" do
    it_behaves_like "public access to characters"

    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to require_login # custom matcher under support/matchers/require_login.rb
      end
    end

    describe "GET #edit" do
      it "requires login" do
        get :edit, params: { id: create(:character) }
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, params: { character: attributes_for(:character) }
        expect(response).to require_login
      end
    end

    describe "PATCH #update" do
      it "requires login" do
        patch :update, params: { id: create(:character), character: attributes_for(:character) }
        expect(response).to require_login
      end
    end

    describe "PATCH #delete_portrait" do
      it "requires login" do
        patch :delete_portrait, params: { id: create(:character_with_portrait) }
        expect(response).to require_login
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
        delete :destroy, params: { id: create(:character) }
        expect(response).to require_login
      end
    end
  end
end
