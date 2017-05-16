class UserNotifier < ApplicationMailer
  default :from => 'anamariasosam@gmail.com'

  def store_order_created(order)
    @order = order
    @product = order.product
    @store = order.store
    @customer = order.customer
    mail( :to => @store.email,
    :subject => "👏 Acabas de vender un #{@product.product_name} en Catlog" )
  end

  def customer_order_created(order)
    @order = order
    @product = order.product
    @store = order.store
    @customer = order.customer
    mail( :to => @customer.email,
    :subject => "🙋 Compraste un #{@product.product_name} en Catlog" )
  end

  def customer_order_updated(order)
    @order = order
    @product = order.product
    @store = order.store
    @customer = order.customer
    mail( :to => @customer.email,
    :subject => "👌 El producto que compraste en Catlog está #{order.status.downcase}" )
  end
end
