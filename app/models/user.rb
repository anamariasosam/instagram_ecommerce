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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          # :recoverable,
          :rememberable,
          :trackable,
          # :validatable,
          :omniauthable,
          omniauth_providers: [:instagram]

  validates :email, uniqueness: true, allow_blank: true, allow_nil: true
  validates_presence_of :city, :country,:email, :phone_number, :on => :update
  validates :phone_number, phone: { possible: true, types: :mobile } , :on => :update
  
  def to_param
    slug
  end

  private

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
end
