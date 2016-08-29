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
  payment_upon_delivery: :boolean,
  pick_up_on_store: :boolean,
  pick_up_instructions: :string

  validates_presence_of :name, on: :update
  validates_presence_of :bank_transfer_instructions, if: :bank_transfer
  validates_presence_of :pick_up_instructions, if: :pick_up_on_store

  def country_name
    ISO3166::Country[country]
  end
end
