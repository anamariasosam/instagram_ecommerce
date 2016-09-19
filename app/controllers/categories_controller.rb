class CategoriesController < ApplicationController
  def show
    @categories = Category.all.order('name ASC')
    @category = @categories.find(params[:id])
    @products = @category.products
                          .page(params[:page])
                          .per(24)
                          .reorder(created_at: :desc)
                          .includes(:store)
  end
end
