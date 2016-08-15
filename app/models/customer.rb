class Customer < User
  has_many :orders

  hstore_accessor :details,
  full_name: :string,
  address: :string

  validates_presence_of :full_name, on: :update
end
