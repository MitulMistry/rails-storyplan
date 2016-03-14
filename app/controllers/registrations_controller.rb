class RegistrationsController < Devise::RegistrationsController
#overrides default Devise controller methods - specified use in routes.rb
  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :username)
  end
end