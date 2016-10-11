# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  product_name    :string
#  price           :integer
#  quantity        :integer
#  instagram_image :string
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  photo_id        :string
#  category_id     :integer          default(1)
#  store_id        :integer
#  deleted_at      :datetime
#

require 'rails_helper'

RSpec.describe Product, type: :model do

  it "has a valid factory" do
    FactoryGirl.build(:product).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:product, product_name: nil).should_not be_valid
  end

  it "is invalid without city" do
    FactoryGirl.build(:product, price: nil).should_not be_valid
  end

  it "is invalid without country" do
    FactoryGirl.build(:product, quantity: nil).should_not be_valid
  end

  it "is invalid without email" do
    FactoryGirl.build(:product, instagram_image: nil).should_not be_valid
  end

  it "is invalid without phone_number" do
    FactoryGirl.build(:product, description: nil).should_not be_valid
  end

end
