class SearchesController < ApplicationController
  def search
    @items = PgSearch.multisearch(params[:search]).reorder("created_at DESC")
  end
end
