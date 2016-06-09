class RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  private

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def sign_up_params
      params.require(:user).permit(:store_name,:store_account, :email, :phone_number, :address, :delivery_info )
    end

    def account_update_params
      params.require(:user).permit(:store_name, :store_account, :email, :phone_number, :address, :delivery_info)
    end
end
