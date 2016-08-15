class Category < ActiveRecord::Base
  has_many :products
  validates :name, presence: true

  def isDefault?
    self.name == 'Sin Categoría'
  end
end
