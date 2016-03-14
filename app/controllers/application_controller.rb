class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #covers most authentication for the website here:
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
end
