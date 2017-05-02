class SearchesController < ApplicationController
  def search
    search_term = params[:search]
    users = User.where("username ILIKE ? OR full_name ILIKE ?", "%#{search_term}", "%#{search_term}")
    stories = Story.where("name ILIKE ?", "%#{search_term}%")
    characters = Character.where("name ILIKE ?", "%#{search_term}")

    @items = users + stories + characters #.order("created_at DESC")
  end
end
