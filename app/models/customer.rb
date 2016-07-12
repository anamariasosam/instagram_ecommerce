class Customer < User
  hstore_accessor :details,
  country: :string
end
