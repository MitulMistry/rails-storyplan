class StoriesController < ApplicationController
  before_action :find_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = Story.all
  end

  def show
  end

  def new
    @story = Story.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @story.destroy
  end

  #-------------------------------
  private
  def find_story
    @story = Story.find(params[:id])
  end
  
  def story_params #strong params
    params.require(:story).permit(:name, :target_word_count, :target_audience, :user_id)
  end
end
