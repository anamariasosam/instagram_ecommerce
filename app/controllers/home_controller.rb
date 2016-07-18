class HomeController < ApplicationController
  def index
    @stores = Store.limit(10)
    @products =  Product.limit(4).order('created_at DESC')

    redirect_to "/#{@par.downcase}" if @par = params[:search]
  end
end
