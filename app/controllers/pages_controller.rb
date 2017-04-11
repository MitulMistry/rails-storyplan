class PagesController < ApplicationController
  def index
    @stories = Story.order("RANDOM()").first(3)
    @writers = User.order("RANDOM()").first(3)
    @characters = Character.order("RANDOM()").first(3)
  end
end
