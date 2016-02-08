json.array!(@products) do |product|
  json.extract! product, :id, :product_name, :price, :quantity, :instagram_image, :description,  :likes
  json.url product_url(product, format: :json)
end
