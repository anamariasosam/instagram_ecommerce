class UsersController < ApplicationController

before_filter :authenticate_user!

  def dashboard
    if current_user.user_token
      client = Instagram.client(:access_token => current_user.user_token)

      @recent_media_items = client.user_recent_media

      current_user.update(
        instagram_id:   client.user.id,
        store_image:    client.user.profile_picture,
        store_account:  client.user.username
      )
    else
      client = Instagram.client(:access_token => session[:access_token])

      @recent_media_items = client.user_recent_media

      current_user.update(
        user_token: session[:access_token],
        instagram_id:   client.user.id,
        store_image:    client.user.profile_picture,
        store_account:  client.user.username
      )
    end

  end

end
