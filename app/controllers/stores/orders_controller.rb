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
end
