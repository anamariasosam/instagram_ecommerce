class HomeController < ApplicationController
  def index
    @users = User.limit(6)
    @products =  Product.limit(5)
  end
end
