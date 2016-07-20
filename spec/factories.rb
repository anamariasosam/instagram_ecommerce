require "faker"

FactoryGirl.define do
  factory :customer do
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
  end

  factory :product do
    product_name { Faker::Commerce.product_name }
    price { Faker::Number.number(5) }
    quantity { Faker::Number.number(1) }
    instagram_image { Faker::Placeholdit.image }
    description { Faker::Lorem.sentence }
  end

  factory :user do
    store_name '@anasosam23'
    phone_number '1234567890'
    info 'fasdfasd'
    instagram_id 'fsad86fs9a87'
    image 'fasdf'
    email 'ana@ama.com'
    encrypted_password '11111'
    user_token '22222'
    store_account '@anasosam23'
    provider 'Instagram'
    uid '4123'
    slug 'anasosam23'
  end

  factory :category do
    name { Faker::Commerce.color }
  end
end
