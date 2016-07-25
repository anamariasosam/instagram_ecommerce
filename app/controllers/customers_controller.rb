class CustomersController < ApplicationController
  before_filter :authenticate_user!
  layout "dashboard"

  def dashboard
    if !session['super_token'].blank?
      current_user.update(user_token: session['super_token'])
    end

    @announcements = Announcement.current
    @activities = PublicActivity::Activity
                                .order("created_at desc")
                                .where(owner_id: current_user)
                                .limit(5)
    @products = list
  end

  def list
    @products = []
    media_id = getMedia

    media_id.each do |media_item|
      @products.push(Product.find_by(photo_id: media_item))
    end

    @products

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

end
