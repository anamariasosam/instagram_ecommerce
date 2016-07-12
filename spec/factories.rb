FactoryGirl.define do
  factory :customer do
    
  end
  factory :store do
    
  end
  factory :product do
    product_name "mani rosado"
    price 1000
    quantity 2
    instagram_image "https://scontent.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/1173135_1016593388379223_512156499_n.jpg"
    description "Nuevo mani"
    photo_id "2"
    user_id "1"
    category_id "1"
  end

  factory :user do
    store_name '@anasosam23'
    phone_number '1234567890'
    address 'fasfasdf'
    delivery_info 'fasdfasd'
    instagram_id 'fsad86fs9a87'
    store_image 'fasdf'
    email 'ana@ama.com'
    encrypted_password '11111'
    user_token '22222'
    store_account '@anasosam23'
    provider 'Instagram'
    uid '4123'
    slug 'anasosam23'
  end

  factory :category do
    name 'ropa'
  end
end
