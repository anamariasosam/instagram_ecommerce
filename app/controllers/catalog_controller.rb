class CatalogController < ApplicationController
  def view
    @categories = Category.all.order('name ASC')

    @products = Product
                          .page(params[:page])
                          .per(12)
                          .order('user_id asc')
                          .order('created_at DESC')
  end
end
