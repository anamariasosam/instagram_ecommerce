# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  store_name             :string
#  phone_number           :string
#  delivery_info          :text
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
#  store_account          :string
#  provider               :string
#  uid                    :string
#  slug                   :string
#  type                   :string(15)
#  details                :hstore
#  city                   :string
#  country                :string
#

class Customer < User
  belongs_to :user
  
  hstore_accessor :details,
  country: :string,
  full_name: :string,
  address: :string
end
