# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  status         :string
#  total          :integer
#  product_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer
#  store_id       :integer
#  payment_method :string
#  details        :text
#  address        :string
#

class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :store
  belongs_to :customer
end
