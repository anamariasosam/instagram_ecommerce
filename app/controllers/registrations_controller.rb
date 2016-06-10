class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      products_path
    end

  private

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def sign_up_params
      params.require(:user).permit(:store_name,:store_account, :email, :phone_number, :address, :delivery_info, :user_token )
    end

    def account_update_params
      params.require(:user).permit(:store_name, :store_account, :email, :phone_number, :address, :delivery_info, :user_token)
    end
end
