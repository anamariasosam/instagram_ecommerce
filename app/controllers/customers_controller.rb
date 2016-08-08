class CustomersController < ApplicationController
  before_filter :authenticate_user!
  layout "dashboard"

  def dashboard
    if current_user.full_name
      if !session['super_token'].blank?
        current_user.update(user_token: session['super_token'])
      end

      @announcements = Announcement.current
      @activities = PublicActivity::Activity
                                  .order("created_at desc")
                                  .where(owner_id: current_user)
                                  .limit(5)
      @products = list

      getInstagramData
    else
      redirect_to edit_user_registration_path
    end
  end

  def list
    @products = []
    media_id = getMedia

    media_id.each do |media_item|
      @products.push(Product.find_by(photo_id: media_item))
    end

    @products
  end

  def media_liked
    response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=" + current_user.user_token)
    @media = response['data']
  end

  def hashtag
    tag = params[:tag]
    @catlogco_media = getHashtagMedia('catlogapp')

    if !tag.nil? and !tag.empty?
      @hashtag = getHashtagMedia(tag)
      @hashtag_text = "#" +  params[:tag]
    else
      @hashtag = getHashtagMedia('productosMedellin')
      @hashtag_text = "#producto"
    end

    @media =  @catlogco_media & @hashtag

    if @media.empty?
      flash[:error] = t('instagram.hashtag_not_found', hashtag: @hashtag_text)
    end
  end

  def orders
    @orders = Order.where("customer_id = :customer_id", customer_id: current_user.id)
  end

  private
    def fillArray(data,array,item)
      data.each do |media|
       array.push(media[item])
      end
    end

    def getMedia
      instagram_photos_id = []
      products_id = []
      products_all = Product.all

      response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=" + current_user.user_token)
      media_liked = response['data']


      fillArray(media_liked, instagram_photos_id, 'id' )
      fillArray(products_all, products_id, 'photo_id' )

      return instagram_photos_id & products_id
    end

    def getInstagramData
      response = HTTParty.get('https://api.instagram.com/v1/users/self/?access_token=' + current_user.user_token)

      current_user.update(
        instagram_id:       response['data']['id'],
        image:              response['data']['profile_picture'],
        instagram_account:  response['data']['username'],
        slug:               response['data']['username']
      )
    end

    def getHashtagMedia(data)
      return HTTParty.get("https://api.instagram.com/v1/tags/#{data}/media/recent?access_token=2129469216.e029fea.33e99327453b40dbbe901e4f36a247c4")['data']
    end
end
