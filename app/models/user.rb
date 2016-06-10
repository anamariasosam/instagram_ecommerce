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

  has_many :products, dependent: :destroy
  validates :email, uniqueness: true, allow_blank: true, allow_nil: true
  validates_presence_of :store_name, :email, :address, :phone_number,  :on => :update
  validates :phone_number, length: { minimum: 10 },  :on => :update
  validates_numericality_of :phone_number,  :on => :update

  private

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
end
