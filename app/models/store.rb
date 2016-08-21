# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  phone_number           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  instagram_id           :string
#  image                  :string
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  user_token             :string
#  instagram_account      :string
#  provider               :string
#  uid                    :string
#  slug                   :string
#  type                   :string(15)
#  details                :hstore
#  city                   :string
#  country                :string
#

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
  snapchat: :string,
  delivery_price: :integer,
  bank_transfer: :boolean,
  bank_transfer_instructions: :string,
  payment_upon_delivery: :boolean

  validates_presence_of :name, on: :update
end
