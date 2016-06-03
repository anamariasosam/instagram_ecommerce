class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :capitalize_store_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :products, dependent: :destroy
  validates_presence_of :phone_number, :address, :store_name
  validates :phone_number , length: { minimum: 10 }


  private
   def capitalize_store_name
       self.store_name = store_name.capitalize
   end
end
