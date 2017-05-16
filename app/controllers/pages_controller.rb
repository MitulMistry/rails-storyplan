class PagesController < ApplicationController
  def index
    @stories = Story.randomized(4)
    @writers = User.randomized(4)
    @characters = Character.randomized(4)
  end
end
