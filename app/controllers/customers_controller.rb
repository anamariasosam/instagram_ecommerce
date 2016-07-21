class CustomersController < ApplicationController
  before_filter :authenticate_user!
  
  def dashboard
    if current_user.user_token?
      if !session['super_token'].blank?
        client = Instagram.client(:access_token => session['super_token'])
        current_user.update(user_token: session['super_token'])
      else
        client = Instagram.client(:access_token => current_user.user_token)
      end

      current_user.update(
        instagram_id:   client.user.id,
        image:    client.user.profile_picture,
        store_account:  client.user.username,
        slug:           client.user.username
      )
    else
      redirect_to edit_user_registration_path
    end
  end
end
