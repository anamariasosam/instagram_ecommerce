class Store < User
  hstore_accessor :details,
  name: :string,
  info: :text,
  slug: :string
end
