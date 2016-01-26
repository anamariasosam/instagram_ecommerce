class UsersController < ApplicationController


def dashboard
  if session[:access_token]
    client = Instagram.client(:access_token => session[:access_token])


    @recent_media_items = client.user_recent_media

    @user = User.create(
      instagram_id:   client.user.id,
      store_name:     client.user.username,
      delivery_info:  client.user.bio,
      store_image:    client.user.profile_picture
    )

    @user.update(store_image: client.user.profile_picture )

  else
    redirect_to :controller => 'sessions', :action => 'connect'
  end
end

end
