class UsersController < ApplicationController

before_filter :authenticate_user!

  def dashboard
    if current_user.user_token
      client = Instagram.client(:access_token => current_user.user_token)

      @recent_media_items = client.user_recent_media

      current_user.update(instagram_id:   client.user.id,
        store_name:     client.user.username,
        delivery_info:  client.user.bio,
        store_image:    client.user.profile_picture)
    else
      redirect_to :controller => 'sessions', :action => 'connect'
    end
  end

end
