require "faker"

FactoryGirl.define do
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
    phone_number { Faker::Number.number(10) }
    slug { Faker::Number.number(10) }
  end

  factory :category do
    name { Faker::Commerce.color }
  end

  factory :product do
    store = FactoryGirl.create(:store)
    category = FactoryGirl.create(:category)
    product_name { Faker::Commerce.product_name }
    price { Faker::Number.number(5) }
    quantity { Faker::Number.number(1) }
    instagram_image { Faker::Placeholdit.image("500x500", 'jpg', Faker::Color.hex_color.to_s.sub(/^#/, '')) }
    description { Faker::Lorem.sentence }
    photo_id { Faker::Number.number(11) }
    store_id store.id
    category_id category.id
  end
end
