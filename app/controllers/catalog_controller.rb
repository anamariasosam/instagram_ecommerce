class CatalogController < ApplicationController
  def view
    @categories = Category.all.order('name ASC')

    @catalog_products = Product
                          .page(params[:page])
                          .per(6)
                          .order('user_id asc')
                          .order('created_at DESC')
  end
end
