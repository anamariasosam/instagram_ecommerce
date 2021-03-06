class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def instagram
    if request.env['omniauth.params']['model'] == "store"
      instagram_auth(true, Store)
    else
      instagram_auth(false, Customer)
    end
  end

  def instagram_auth(is_store, user)
    user_instance = is_store ? @store : @customer

    user_instance = user.from_omniauth(request.env["omniauth.auth"])

    if user_instance.persisted?
      sign_in_and_redirect user_instance, :event => :authentication #this will throw if user_instance is not activated
      set_flash_message(:notice, :success, :kind => "Instagram") if is_navigational_format?
    else
     session["devise.instagram_data"] = request.env["omniauth.auth"]
     redirect_to new_user_session_url
    end
  end

  def failure
    redirect_to root_path
  end
end
