class StoriesController < ApplicationController
  before_action :find_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = Story.order(created_at: :desc).page(params[:page]) #kaminari
  end

  def show
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user #sets the user_id of the story to the current user
    #@story = current_user.stories.build(story_params) #use build to set the story user_id to the current user

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
      else
        format.html { render :new, alert: 'Story creation failed.' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
      else
        format.html { render :edit, alert: 'Story update failed.' }
      end
    end
  end

  def destroy #destroy chapters as well???
    @story.destroy

    respond_to do |format|
      format.html { redirect_to my_stories_path, notice: 'Story was successfully deleted.' }
    end
  end

  #-------------------------------
  private

  def find_story
    @story = Story.find(params[:id])
  end

  def story_params #strong params
    params.require(:story).permit(:name, :target_word_count, :target_audience, :overview, :genre_ids)
  end
end
