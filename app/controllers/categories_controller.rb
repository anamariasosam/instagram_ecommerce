class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all.order('name ASC')
    @products = @category.products
                          .page(params[:page])
                          .per(8)
                          .order('store_id asc')
                          .order('created_at DESC')
  end
end
