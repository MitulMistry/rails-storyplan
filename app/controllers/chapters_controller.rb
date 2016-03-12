class ChaptersController < ApplicationController
  before_action :find_chapter, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @chapter = Chapter.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @chapter.destroy
  end

  #-------------------------------
  private
  def find_chapter
    @chapter = Chapter.find(params[:id])
  end

  def chapter_params #strong params
    params.require(:chapter).permit(:name, :objective, :target_word_count, :overview, :story_id)
  end
end
