class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_stories = @genre.stories.order(created_at: :desc).page(params[:page]) #kaminari
  end
end
