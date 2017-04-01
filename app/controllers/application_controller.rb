class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

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

  #-------------------------------
  private

  def catch_not_found #if the record (character, story, etc.) isn't found, redirect to root path. Or, can remove this rescue_from and just let it redirect to 404 page in production.
    redirect_to root_path, flash: { error: "Record not found."}
  end
end
