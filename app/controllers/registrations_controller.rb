class RegistrationsController < Devise::RegistrationsController

  def edit
    get_instagram_data
    super
  end

  def update
    if not @user.update(account_update_params)
      get_instagram_data
    end
    super
  end

  protected

    def after_update_path_for(resource)
      if resource.is_a?(Store)
        stores_dashboard_path
      elsif resource.is_a?(Customer)
        stored_location_for(resource) || customers_dashboard_path
      elsif resource.is_a?(AdminUser)
        admin_dashboard_path
      else
        root_path
      end
    end

  private

    def get_instagram_data
      # Know the first edit
      if not current_user.country?
        client = Instagram.client(access_token: current_user.user_token)
        fill_data(client)
      end
    end

    def fill_data(client)
      if current_user.type == "Store"
        store = current_user
        store.name ||=  client.user.full_name
        store.info ||=  client.user.bio
        store.facebook ||=  get_facebook(client)
      else
        current_user.full_name ||=  client.user.full_name
      end
    end

    def get_facebook(client)
      if client.user.website.include? "facebook"
        client.user.website.split('/')[-1]
      end
    end

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
                      :snapchat
                    )
    end
end
