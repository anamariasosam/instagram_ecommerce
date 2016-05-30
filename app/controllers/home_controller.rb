class HomeController < ApplicationController
  def index
    @users = User.limit(6)
    @products =  Product.limit(3)

    redirect_to "/#{@par.downcase}" if @par = params[:search]
  end
end
