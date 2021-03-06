class HomeController < ApplicationController
  def index
    @stores = Store.joins(:products).group('id').order(created_at: :desc)
    @products =  Product.limit(4).order(created_at: :desc).includes(:store)

    @category = Category.find_by_name('Accesorios')
    @bags = @category.products.limit(4).includes(:store) if @category

    redirect_to "/#{@par.downcase}" if @par = params[:search]
  end
end
