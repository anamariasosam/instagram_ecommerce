class OrdersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :require_store, only: [:edit, :destroy]

  def new
    product = Product.find(params[:product])
    @product_id = product.id
    @customer_id = current_user.id
    @store_id = product.store_id
    @total = product.price
    @status = "Pendiente"
    super
  end

  private

    def order_params
      params.require(:order).permit(:status, :product_id, :customer_id, :store_id)
    end

    def require_store
      if current_user.type == "Customer"
        flash[:error] = "No eres tienda"
        redirect_to root_url
      end
    end
end
