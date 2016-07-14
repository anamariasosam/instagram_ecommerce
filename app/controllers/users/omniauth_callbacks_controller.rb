class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def instagram
    if request.env['omniauth.params']['model'] == "store"
      @store = Store.from_omniauth(request.env["omniauth.auth"])
      session['super_token'] = request.env["omniauth.auth"]["credentials"]["token"]

      if @store.persisted?
       sign_in_and_redirect @store, :event => :authentication #this will throw if @store is not activated
       set_flash_message(:notice, :success, :kind => "Instagram") if is_navigational_format?
     else
       session["devise.instagram_data"] = request.env["omniauth.auth"]
       redirect_to new_store_registration_url
     end
    end

  end

  def failure
    redirect_to root_path
  end

end
