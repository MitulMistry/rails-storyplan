class SearchesController < ApplicationController
  def search #returns PgSearch::Document instances - user item.searchable to get the referring object
    @items = PgSearch.multisearch(params[:search]).reorder("created_at DESC").page(params[:page]) #kaminari
  end
end
