class RegistrationsController < Devise::RegistrationsController
  protected

    def after_update_path_for(resource)
      users_dashboard_path
    end

  private

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def account_update_params
      params.require(:user).permit(:name, :store_account, :email, :phone_number, :user_token, :city, :info, :country)
    end
end
