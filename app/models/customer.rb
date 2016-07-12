class Customer < User
  hstore_accessor :details,
  country: :string,
  state: :string,
  full_name: :string,
  address: :text
end
