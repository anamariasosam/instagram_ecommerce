class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:dashboard]

  def show
    @user = User.find(params[:id])
    @products = @user.products.page(params[:page]).per(6).order('created_at DESC')
  end

  def dashboard
    if current_user.user_token?
      client = Instagram.client(:access_token => current_user.user_token)

      response = client.user_recent_media
      album = [].concat(response)
      max_id = response.pagination.next_max_id

      while !(max_id.to_s.empty?) do
          response = client.user_recent_media(:max_id => max_id)
          max_id = response.pagination.next_max_id
          album.concat(response)
      end

      @media = Kaminari.paginate_array(album).page(params[:page]).per(40)

      current_user.update(
        instagram_id:   client.user.id,
        store_image:    client.user.profile_picture,
        store_account:  client.user.username
      )
    else
      redirect_to edit_user_registration_path
    end
  end
end
