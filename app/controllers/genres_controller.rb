class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @genre_stories = @genre.ordered_stories.page(params[:page]) #kaminari
  end
end
