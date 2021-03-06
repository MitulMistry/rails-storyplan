class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] #Devise authentication - check if user is logged in
  before_action :find_story, only: [:show, :edit, :update, :delete_cover, :destroy]
  before_action :authorize_ownership, only: [:edit, :update, :delete_cover, :destroy]

  def index
    if params[:writer_id] #check for nested route
      @stories = User.find(params[:writer_id]).stories.ordered.page(params[:page]) #kaminari
    else
      @stories = Story.ordered.page(params[:page]) #kaminari
    end
  end

  def show
    @comment = Comment.new if user_signed_in?
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.build(story_params) #use build to set the story user_id to the current user

    if @story.save
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render :new, alert: 'Story creation failed.'
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render :edit, alert: 'Story update failed.'
    end
  end

  def delete_cover
    @story.cover = nil
    @story.save
    redirect_to @story, notice: 'Image was successfully deleted.'
  end

  def destroy
    @story.destroy #this destroys associated chapters as well
    redirect_to my_stories_path, notice: 'Story was successfully deleted.'
  end

  #-------------------------------
  private

  def find_story
    @story = Story.find(params[:id])
  end

  def authorize_ownership
    if @story.user != current_user
      redirect_to stories_path, alert: 'You do not have required permissions.'
      return #guard clause
    end
  end

  def story_params #strong params
    params.require(:story).permit(:name, :target_word_count, :overview, :cover, audience_ids: [], genre_ids: [])
  end
end
