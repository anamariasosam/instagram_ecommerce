class StoresController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard, :subscribe, :list]
  before_filter :require_store, only: [:dashboard, :subscribe, :list]
  before_filter :pilot_store, only: [:dashboard, :list, :instagram_media]
  before_filter :edit_store_info, only: [:dashboard]
  layout 'dashboard', except: [:show, :subscribe]


  def show
    @store = Store.find_by(slug: params[:id])
    @products = @store.products.page(params[:page]).per(24).order('created_at DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end

  def subscribe
    @waiting_users =  Store.where("details->'pilot' = ?", "false").all.count
    @waiting_position = current_user.waiting_position

    client = Instagram.client(:access_token => current_user.user_token)
    update_instagram_data(client)
  end

  def instagram_media
    if current_user.user_token?
      options = { count: 40 }
      options[:max_id] = params[:max_id] if params[:max_id]

      if !session['super_token'].blank?
        current_user.update(user_token: session['super_token'])
      end

      client = Instagram.client(:access_token => current_user.user_token)
      media = client.user_recent_media("self", options)
      products =  current_user.products

      media.each do |product|
        product.already_on_db = products.exists? photo_id: product.id
      end

      @media = media

      update_instagram_data(client)

      if @media.last.nil?
        @media = client.user_recent_media
      end

    else
      redirect_to edit_user_registration_path
    end
  end

  def dashboard
    if !session['super_token'].blank?
      current_user.update(user_token: session['super_token'])
    end

    client = Instagram.client(:access_token => current_user.user_token)
    update_instagram_data(client)

    @activities = PublicActivity::Activity
      .order("created_at desc")
      .where(owner_id: current_user)
      .limit(5)
      .includes(:trackable)
    @announcements = Announcement.current

  end

  def payments_and_delivery
    if params[:payments_and_delivery]
      data = params[:payments_and_delivery]

      respond_to do |format|
        if current_user.update(
          delivery_price: data[:delivery_price],
          bank_transfer: data[:bank_transfer],
          bank_transfer_instructions: data[:bank_transfer_instructions],
          payment_upon_delivery: data[:payment_upon_delivery]
        )

          format.html { redirect_to stores_dashboard_path, notice: "Datos Guardados" }
        end
      end
    end
  end

  # private methods
  private
    def update_instagram_data(client)
      current_user.update(
        instagram_id:       client.user.id,
        image:              client.user.profile_picture,
        instagram_account:  client.user.username,
        slug:               client.user.username
      )
    end

    def require_store
      if current_user.type == "Customer"
        flash[:error] = t('user.no_store')
        redirect_to root_url
      end
    end

    def pilot_store
      if !current_user.pilot? and current_user.name
        flash[:error] = t('user.no_pilot')
        redirect_to stores_subscribe_path
      end
    end

    def edit_store_info
      if !current_user.name
        redirect_to edit_user_registration_path
      end
    end
end
