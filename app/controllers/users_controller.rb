class UsersController < ApplicationController

before_filter :authenticate_user!

  def dashboard
      client = Instagram.client(:access_token => session[:access_token])

      @recent_media_items = client.user_recent_media

      current_user.update(
        user_token: session[:access_token],
        instagram_id:   client.user.id,
        store_image:    client.user.profile_picture)
  end

end
