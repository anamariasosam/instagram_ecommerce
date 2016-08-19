class RegistrationsController < Devise::RegistrationsController
  protected

    def after_update_path_for(resource)
      if resource.is_a?(Store)
        stores_dashboard_path
      elsif resource.is_a?(Customer)
        customers_dashboard_path
      elsif resource.is_a?(AdminUser)
        admin_dashboard_path
      else
        root_path
      end
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
                      :address,
                      :facebook,
                      :twitter,
                      :snapchat,
                      :delivery_price
                    )
    end
end
