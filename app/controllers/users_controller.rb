class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:dashboard, :suscribe, :list]
  before_filter :require_store, only: [:dashboard, :suscribe, :list]

  def oauth_failure
  end

  def suscribe
    @waiting_users =  Store.where("details->'pilot' = ?", "false").all.count
    @waiting_position = current_user.waiting_position
  end

  def list
    if current_user.user_token?
      if !session['super_token'].blank?
        current_user.update(user_token: session['super_token'])
      end

      client = Instagram.client(:access_token => current_user.user_token)

      current_user.update(
        instagram_id:       client.user.id,
        image:              client.user.profile_picture,
        instagram_account:  client.user.username,
        slug:               client.user.username
      )

      if current_user.type.eql?("Store") and current_user.pilot?
        @options = { count: 40}
        @options[:max_id] = params[:max_id] if params[:max_id]
        @media = client.user_recent_media("self", @options)
        if @media.last.nil?
          @media = client.user_recent_media
        end
      else
        redirect_to users_suscribe_path
      end
    else
      redirect_to edit_user_registration_path
    end
    render :layout => 'dashboard'
  end

  def dashboard
    if current_user.user_token?
      if !session['super_token'].blank?
        current_user.update(user_token: session['super_token'])
      end
      @activities = PublicActivity::Activity
                                  .order("created_at desc")
                                  .where(owner_id: current_user)
                                  .limit(5)
      @announcements = Announcement.current
    else
      redirect_to edit_user_registration_path
    end
    render :layout => 'dashboard'
  end

  private
    def require_store
      if current_user.type == "Customer"
        flash[:error] = "No eres tienda"
        redirect_to root_url
      end
    end

end
