require 'factory_girl'

5.times do

  category = FactoryGirl.create(:category)
  store = FactoryGirl.create(:store)

  10.times do
    FactoryGirl.create(:product, category_id: category.id, store_id: store.id)
  end

end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
