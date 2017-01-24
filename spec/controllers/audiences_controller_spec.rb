require 'rails_helper'

RSpec.describe AudiencesController, type: :controller do
  shared_examples_for "public access to audiences" do
    describe "GET #index" do
      it "populates an array of all audiences" do
        audience1 = create(:audience)
        audience2 = create(:audience)
        audience3 = create(:audience)
        get :index
        expect(assigns(:audiences)).to match_array([audience1, audience2, audience3])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      before :each do
        @audience = create(:audience) # FactoryGirl, invoke audience factory
      end

      it "assigns the requested audience to @audience" do
        get :show, params: { id: @audience } # make a GET request with id for audience
        expect(assigns(:audience)).to eq @audience # assigns checks value of @audience in controller
      end

      it "populates an array of the audience's stories per page (by creation date)" do
        story1 = create(:story)
        story2 = create(:story)
        story3 = create(:story)

        @audience.stories << story1
        @audience.stories << story3

        get :show, params: { id: @audience }
        expect(assigns(:audience_stories)).to eq [story3, story1]
      end

      it "renders the :show template" do
        get :show, params: { id: @audience }
        expect(response).to render_template :show # response is finished product returned from controller
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user) # FactoryGirl
      sign_in @user # sign in via Devise::Test::ControllerHelpers
    end

    it_behaves_like "public access to audiences"
  end

  describe "guest access" do
    it_behaves_like "public access to audiences"
  end
end
