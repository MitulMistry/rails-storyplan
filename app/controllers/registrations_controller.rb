class RegistrationsController < Devise::RegistrationsController
  #overrides default Devise controller methods - specified use in routes.rb

  # Overwrite update_resource to let OAuth users make an update without a password
  def update_resource(resource, params)
    if current_user.provider == "facebook"
      #params.delete("current_password")
      params.except!(:password, :password_confirmation, :current_password) #removes keys if there
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :full_name, :bio)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :username)
  end
end
