class Category < ActiveRecord::Base
  has_many :products

  def isDefault?
    self.name == 'Sin Categoría'
  end
end
