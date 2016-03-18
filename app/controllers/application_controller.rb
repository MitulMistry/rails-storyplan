class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #covers most authentication for the website here:
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  #devise redirects
  def after_sign_in_path_for(resource)
    profile_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def after_update_path_for(resource)
    profile_path
  end
end
