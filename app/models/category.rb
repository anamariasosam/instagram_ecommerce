# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :products
  validates :name, presence: true

  def isDefault?
    self.name == 'Sin Categoría'
  end
end
