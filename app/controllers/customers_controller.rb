class CustomersController < ApplicationController
  before_filter :authenticate_user!
  layout 'dashboard'

  def dashboard
    if current_user.email?
      if !session['super_token'].blank?
        current_user.update(user_token: session['super_token'])
      end

      @announcements = Announcement.current
      @activities = PublicActivity::Activity
        .order("created_at desc")
        .where(owner_id: current_user)
        .limit(5).includes(:trackable)

      getInstagramData
    else
      redirect_to edit_user_registration_path
    end
  end

  def orders
    @orders = current_user.orders.includes(:store).includes(:product).reorder(created_at: :desc)
  end

  private
    def getInstagramData
      client = Instagram.client(access_token: current_user.user_token)

      current_user.update(
        image:              client.user.profile_picture,
        instagram_account:  client.user.username,
        slug:               client.user.username
      )
    end
end
