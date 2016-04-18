class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
    client = Instagram.client(:access_token => session[:access_token])
    @user_info = client.user
  end

  private

  def sign_up_params
    params.require(:user).permit(:store_name,:store_account, :email, :phone_number, :address, :delivery_info, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:store_name, :store_account, :email, :phone_number, :address, :delivery_info, :password, :password_confirmation, :current_password)
  end
end

