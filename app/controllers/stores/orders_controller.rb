require 'twilio-ruby'

class Stores::OrdersController < ApplicationController
  include TwilioNotify

  before_action :authenticate_user!
  before_action :require_store
  before_action :pilot_store, only: [:index, :show, :update]
  before_action :set_order, only: [:show, :update]
  before_action :set_states, only: [:show, :update]


  layout 'dashboard'

  def index
    @orders = current_user.orders.includes(:customer).includes(:product).reorder(:created_at)
  end

  def show
  end

  def update
    respond_to do |format|
      if @order.update( params.require(:order).permit(:status) )
        # @order.create_activity :update, owner: current_user

        notify('customer', @order)
        notify('store', @order)

        @order.create_activity :status, owner: @order.store, parameters: {order_status: @order.status}
        @order.create_activity :status, owner: @order.customer, parameters: {order_status: @order.status}

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
        'Esperando Consignación',
      ]
    end

    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def require_store
      if current_user.type == "Customer"
        flash[:error] = t('user.no_store')
        redirect_to root_url
      end
    end

    def pilot_store
      if !current_user.pilot?
        flash[:error] = t('user.no_pilot')
        redirect_to stores_subscribe_path
      end
    end
end
