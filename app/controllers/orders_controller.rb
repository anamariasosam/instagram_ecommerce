require 'twilio-ruby'

class OrdersController < ApplicationController
  before_action :set_product
  before_action :set_payment_methods, only: [:new]
  before_action :authenticate_user!
  before_action :only_customers, only: [:new]

  def new
    order = Order.new
    order.total = @product.price
    @order = order
  end

  def create
    @order = Order.new(params.require(:order).permit(:address, :payment_method, :details))
    customer = current_user

    respond_to do |format|
      @order.customer_id = current_user.id
      @order.store_id = @product.store.id
      @order.product_id = @product.id
      @order.total = @product.price
      @order.status = 'En Proceso'

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
      @payment_methods = [
        'Contra Entrega',
        'Consignación Bancaria',
      ]
    end

    def notify(who, order, first = false)
      store = order.store.name
      customer = order.customer.full_name
      article = order.product.product_name
      status = order.status

      phone = case who
        when 'store'
          order.store.phone_number
        when 'customer'
          order.customer.phone_number
        end

      body = "Hola #{store.truncate(17)}, "

      body += case who
        when "store"
          if first
            "Acabas de vender 1 #{article} a #{customer} en catlog.co; actualiza el estado de la orden en la plataforma;"
          else
            "Acabamos de informar a #{customer} que el artículo #{article} se encuentra"
          end
        when "customer"
          if first
            "Acabas de comprar 1 #{article} de #{store} en catlog.co; por aquí te contaremos sobre el estado de tu orden,"
          else
            "Te contamos que el artículo #{article} se encuentra"
          end
        end

      body += " actualmente: #{status}"

      # client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      # message = client.messages.create from: '+12513016556', to: "+57#{phone}", body: body
    end
end
