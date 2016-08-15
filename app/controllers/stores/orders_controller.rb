require 'twilio-ruby'

class Stores::OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_order, only: [:show, :update]
  before_action :set_states, only: [:show, :update]

  layout 'dashboard'

  def index
    @orders = Order.where("store_id = :store_id", store_id: current_user.id)
  end

  def show
  end

  def update
    respond_to do |format|
      if @order.update( params.require(:order).permit(:status) )
        # @order.create_activity :update, owner: current_user

        notify('customer', @order)
        notify('store', @order)

        format.html { redirect_to ['stores', @order], notice: 'El estado de la orden ha sido actualizado exitosamente' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :show }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_states
      @state_options = [
        'En Proceso',
        'Listo Para Enviar',
        'Enviado',
        'Entregado',
      ]
    end

    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def notify(who, order, first = false)
      store = order.store.store_name
      customer = order.customer.full_name
      article = order.product.product_name
      status = order.status

      phone = case who
        when 'store'
          order.customer.phone_number
        when 'customer'
          order.store.phone_number
      end

      body = "Hola #{store.truncate(17)}, "

      body += case who
        when "store" && first
          "Acabas de vender 1 #{article} a #{customer} en catlog.co; actualiza el estado de la orden en la plataforma;"
        when "store"
          "Acabamos de informar a #{customer} que el artículo #{article} se encuentra"
        when "customer" && first
          "Acabas de comprar 1 #{article} de #{store} en catlog.co; por aquí te contaremos sobre el estado de tu orden,"
        when "customer"
          "Te contamos que el artículo #{article} se encuentra"
      end

      body += " actualmente: #{status}"

      # client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
      # message = client.messages.create from: '+12513016556', to: "+57#{phone}", body: body
    end

end
