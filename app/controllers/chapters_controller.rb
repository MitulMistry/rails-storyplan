class ChaptersController < ApplicationController
  before_action :find_chapter, only: [:show, :edit, :update, :destroy]
  before_action :authorize_ownership, only: [:edit, :update, :destroy]
  before_action :check_for_stories, only: [:new, :create]

  def show
  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: 'Chapter was successfully created.' }
      else
        format.html { render :new, alert: 'Chapter creation failed.' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
      else
        format.html { render :edit, alert: 'Chapter update failed.' }
      end
    end
  end

  def destroy
      @chapter.destroy

      respond_to do |format|
        format.html { redirect_to my_stories_path, notice: 'Chapter was successfully deleted.' }
      end
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
    params.require(:chapter).permit(:name, :objective, :target_word_count, :overview, :story_id, character_ids: [], characters_attributes: [:name, :user_id])
  end
end
