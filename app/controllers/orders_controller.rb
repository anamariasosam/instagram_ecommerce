class OrdersController < ApplicationController
  before_action :set_product
  before_action :authenticate_user!

  def new
    order = Order.new
    order.total = @product.price
    @order = order
  end

  def create
    @order = Order.new(params.permit(:address))
    customer = current_user

    respond_to do |format|
      @order.customer_id = current_user.id
      @order.store_id = @product.store.id
      @order.product_id = @product.id
      @order.total = @product.price
      @order.status = 'En proceso'

      if @order.save
        # order needs to be trackable
        # @order.create_activity :purchase, owner: @product.store
        format.html { redirect_to thnks_fr_th_mmrs_product_orders_path(order: @order), notice: "Tu orden ha sido creada" }
        format.json { render :index, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def thnks_fr_th_mmrs
    @result = current_user.orders.last
  end

  private

    def set_product
      @product = Product.find params[:product_id]
    end
end
