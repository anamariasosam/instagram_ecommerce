class User < ActiveRecord::Base
  has_many :product
  validates :store_name, uniqueness: true

end
