json.array!(@orders) do |order|
  json.extract! order, :id, :status, :product_id, :customer_id, :store_id
  json.url order_url(order, format: :json)
end
