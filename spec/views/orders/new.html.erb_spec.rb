require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :status => "MyString",
      :product => nil,
      :customer => nil,
      :store => nil
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_status[name=?]", "order[status]"

      assert_select "input#order_product_id[name=?]", "order[product_id]"

      assert_select "input#order_customer_id[name=?]", "order[customer_id]"

      assert_select "input#order_store_id[name=?]", "order[store_id]"
    end
  end
end
