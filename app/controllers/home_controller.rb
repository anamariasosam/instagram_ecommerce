class HomeController < ApplicationController
  def index
    @stores = Store.includes(:products)
    @products =  Product.limit(4).order(created_at: :desc).includes(:store)

    @category = Category.find_by_name('Bolsos')
    @bags = @category.products.limit(4).includes(:store) if @category

    redirect_to "/#{@par.downcase}" if @par = params[:search]
  end
end
