class HomeController < ApplicationController
  def index
    @users = User.all
    @products =  Product.limit(5)
  end
end
