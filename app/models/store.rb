class Store < User
  has_many :products, dependent: :destroy
  has_many :orders

  hstore_accessor :details,
  name: :string,
  info: :string,
  pilot: :boolean,
  waiting_position: :integer,
  facebook: :string,
  twitter: :string,
  snapchat: :string


  validates_presence_of :name, on: :update
end
