class UsersController < ApplicationController

before_filter :authenticate_user!
before_filter :current_user

  def dashboard
    session["devise.instagram_data"]
    # https://api.instagram.com/v1/users/self/media/recent/?access_token=ACCESS-TOKEN

  end

end
