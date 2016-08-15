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
