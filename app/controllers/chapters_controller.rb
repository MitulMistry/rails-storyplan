class ChaptersController < ApplicationController
  before_action :find_chapter, only: [:show, :edit, :update, :destroy]
  before_action :authorize_ownership, only: [:edit, :update, :destroy]
  before_action :check_for_stories, only: [:new, :create]

  def index
    if params[:writer_id] #check for nested route
      @chapters = User.find(params[:writer_id]).chapters.page(params[:page]) #kaminari
    else
      @chapters = Chapter.ordered.page(params[:page]) #kaminari
    end
  end

  def show
  end

  def new
    if params[:story_id] #check to see if this is a nested route coming from a story
      story = Story.find_by_id(params[:story_id])
      if story.nil?
        redirect_to stories_path, alert: "Story not found"
      elsif story.user != current_user #check to see if the story is owned by the current user
        redirect_to stories_path, alert: "You do not have required permissions"
      end
    end

    @chapter = Chapter.new(story_id: params[:story_id]) #story_id set for nested route if coming from story and set in form collection_select, otherwise it's nil and that's what it would be anyway
  end

  def create
    @chapter = Chapter.new(chapter_params)
    if @chapter.save
      redirect_to @chapter, notice: 'Chapter was successfully created.'
    else
      render :new, alert: 'Chapter creation failed.'
    end
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to @chapter, notice: 'Chapter was successfully updated.'
    else
      render :edit, alert: 'Chapter update failed.'
    end
  end

  def destroy
    @chapter.destroy
    redirect_to my_stories_path, notice: 'Chapter was successfully deleted.'
  end

  #-------------------------------
  private

  def find_chapter
    @chapter = Chapter.find(params[:id])
  end

  def check_for_stories
    if current_user.stories.empty?
      redirect_to new_story_path, alert: 'You need at least one story before you can create a chapter.'
      #redirect_to new_story_path, flash: { error: "You need to create a story before you can create a chapter." }
    end
  end

  def authorize_ownership
    if @chapter.user != current_user
      redirect_to root_path, alert: 'You do not have required permissions.'
    end
  end

  def chapter_params #strong params
    params.require(:chapter).permit(:name, :objective, :target_word_count, :overview, :story_id, :currently_writing, character_ids: [], characters_attributes: [:name])
  end
end
