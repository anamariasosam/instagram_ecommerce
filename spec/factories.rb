require "faker"

FactoryGirl.define do
  factory :order do
    product_name "MyString"
    product_price 1
    delivery_price 1
    order_total 1
    store_name "MyString"
    store_instagram "MyString"
    customer_name "MyString"
    customer_instagram "MyString"
    store_email "MyString"
    customer_email "MyString"
    store_phone "MyString"
    customer_phone "MyString"
    customer_ip_address "MyString"
    invoice_number "MyString"
    tracking_number "MyString"
    delivery_instructions "MyText"
    payment_method "MyString"
    customer_address "MyString"
    customer_city "MyString"
    order_state "MyString"
  end
  factory :announcement do
    message "MyText"
    start_at "2016-07-23 15:50:48"
    ends_at "2016-07-23 15:50:48"
  end
  
  factory :customer do
    full_name { Faker::Name.name }
    city { Faker::Address.city }
    country { Faker::Address.country }
    email { Faker::Internet.email }

    # TODO: fix model validation to accept real user typos
    # phone_number { Faker::PhoneNumber.cell_phone }
    phone_number "1234567890"
  end

  factory :store do
    name { Faker::Name.name }
    city { Faker::Address.city }
    country { Faker::Address.country }
    email { Faker::Internet.email }

    # TODO: fix model validation to accept real user typos
    # phone_number { Faker::PhoneNumber.cell_phone }
    phone_number "1234567890"
    slug { Faker::Number.number(10) }
  end

  factory :product do
    product_name { Faker::Commerce.product_name }
    price { Faker::Number.number(5) }
    quantity { Faker::Number.number(1) }
    instagram_image { Faker::Placeholdit.image("500x500", 'jpg', Faker::Color.hex_color.to_s.sub(/^#/, '')) }
    description { Faker::Lorem.sentence }
  end

  factory :user do
    store_name { Faker::Company.name }
    phone_number '1234567890'
    delivery_info { Faker::Lorem.sentence }
    details { Faker::Lorem.sentence }
    city { Faker::Address.city }
    country { Faker::Address.country }
  end

  factory :category do
    name { Faker::Commerce.color }
  end
end
