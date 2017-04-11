class PagesController < ApplicationController
  def index
    @stories = Story.randomized(3)
    @writers = User.randomized(3)
    @characters = Character.randomized(3)
  end
end
