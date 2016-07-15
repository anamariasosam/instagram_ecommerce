class StoresController < ApplicationController
  
  def show
    @store = Store.find_by(slug: params[:id])
    @products = @store.products.page(params[:page]).per(24).order('created_at DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @store }
    end
  end
end
