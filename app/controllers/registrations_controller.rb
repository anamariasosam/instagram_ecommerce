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
      params.require(:user)
              .permit(:name,
                      :instagram_account,
                      :email,
                      :phone_number,
                      :address,
                      :info,
                      :user_token,
                      :waiting_position,
                      :city,
                      :country,
                      :pilot,
                      :full_name,
                      :address
                    )
    end
end
