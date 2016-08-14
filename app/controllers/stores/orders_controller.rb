class Stores::OrdersController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
    @orders = Order.where("store_id = :store_id", store_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

end
