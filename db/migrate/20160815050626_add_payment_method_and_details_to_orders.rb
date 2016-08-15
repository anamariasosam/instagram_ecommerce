class AddPaymentMethodAndDetailsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :details, :text
  end
end
