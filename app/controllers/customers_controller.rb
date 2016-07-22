class CustomersController < ApplicationController
  before_filter :authenticate_user!

  def fillArray(data,array,item)
    data.each do |media|
     array.push(media[item])
    end
  end

  def getMedia()
    instagram_photos_id = []
    products_id = []
    products_all = Product.all

    response = HTTParty.get("https://api.instagram.com/v1/users/self/media/liked?access_token=" + current_user.user_token)
    media_liked = response['data']

    fillArray(media_liked, instagram_photos_id, 'id' )
    fillArray(products_all, products_id, 'photo_id' )

    return instagram_photos_id & products_id
  end

  def getProducts()
    @products = []
    media_id = getMedia()

    media_id.each do |media_item|
      @products.push(Product.find_by(photo_id: media_item))
    end

    @product = @products.shift()

    if @products.empty? and !@product.blank?
      redirect_to product_path(@product)
    end

  end

  def dashboard
    if !session['super_token'].blank?
      current_user.update(user_token: session['super_token'])
    end

    getProducts()
    render :layout => 'dashboard'
  end

end
