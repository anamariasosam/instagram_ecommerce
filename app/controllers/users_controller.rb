class UsersController < ApplicationController

  before_filter :authenticate_user!

  def dashboard

      if current_user.user_token
        client = Instagram.client(:access_token => current_user.user_token)
      else
        client = Instagram.client(:access_token => session["devise.instagram_data"]["credentials"]["token"])
        current_user.update( user_token: session["devise.instagram_data"]["credentials"]["token"])
      end

      @recent_media_items = client.user_recent_media
      current_user.update(
        instagram_id:   client.user.id,
        store_image:    client.user.profile_picture,
        store_account:  client.user.username
      )
      # @options = { count: 20}
      # @options[:max_id] = params[:max_id] if params[:max_id]

      # @recent_media_items = client.user_recent_media("self", @options)

      # if @recent_media_items.last.nil?
      #   @recent_media_items = client.user_recent_media
      # end
  end
end
