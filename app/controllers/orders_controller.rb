require 'twilio-ruby'

class OrdersController < ApplicationController
  include TwilioNotify

  before_action :set_product
  before_action :set_payment_methods
  before_action :authenticate_user!
  before_action :only_customers, only: [:new]

  def new
    order = Order.new
    order.total = @product.price + (@product.store.delivery_price || 0)
    @order = order
  end

  def create
    @order = Order.new(params.require(:order).permit(:address, :payment_method, :details))
    customer = current_user

    respond_to do |format|
      fill_data

      if @payment_methods.empty?
        @order.payment_method = 'A Convenir'
      end

      if @order.save
        # order needs to be trackable
        @order.create_activity :create, owner: @order.store
        @order.create_activity :create, owner: @order.customer

        UserNotifier.store_order_created(@order).deliver
        UserNotifier.customer_order_created(@order).deliver

        format.html { redirect_to thnks_fr_th_mmrs_product_orders_path(order: @order), notice: "Tu orden ha sido creada" }
        format.json { render :index, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        set_payment_methods
      end
    end
  end

  def thnks_fr_th_mmrs
    @result = current_user.orders.last

    notify('customer', @result, true)
    notify('store', @result, true)
  end

  private

    def only_customers
      if current_user.type == "Store"
        flash[:error] = t('user.no_customer')
        redirect_to :back
      end
    end

    def set_product
      @product = Product.find params[:product_id]
    end

    def set_payment_methods
      @payment_methods = []
      if @product.store.bank_transfer?
        @payment_methods.push('Consignación Bancaria')
      end
      if @product.store.payment_upon_delivery?
        @payment_methods.push('Contra Entrega')
      end
    end

    def fill_data
      @order.customer_id = current_user.id
      @order.store_id = @product.store.id
      @order.product_id = @product.id
      @order.total = @product.price + (@product.store.delivery_price || 0)

      first_status
    end

    def first_status
      if @order.payment_method == "Consignación Bancaria"
        @order.status = 'Esperando Consignación'
      else
        @order.status = 'En Proceso'
      end
    end
end
