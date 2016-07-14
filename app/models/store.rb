class Store < User
  hstore_accessor :details,
  name: :string,
  info: :string,
  slug: :string

  has_many :products, dependent: :destroy
end
