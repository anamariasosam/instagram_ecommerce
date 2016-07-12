class Store < User
  hstore_accessor :details,
  name: :string
end
