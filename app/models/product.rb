# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  product_name    :string
#  price           :integer
#  quantity        :integer
#  instagram_image :string
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  photo_id        :string
#  user_id         :integer
#  category_id     :integer          default(1)
#

class Product < ActiveRecord::Base
  after_create :magic

  has_shortened_urls

  belongs_to :category

  validates_presence_of :instagram_image,
                        :price,
                        :description,
                        :product_name
  validates_numericality_of :price, :quantity
  validates :price, length: { minimum: 4 }
  validates :description, length: { maximum: 500 }
  validates_length_of :product_name, :maximum => 40

  belongs_to :store

  def slug
    store.name.downcase.gsub(" ", "-") + "_"  + product_name.downcase.gsub(" ", "-")
  end

  def to_param
    "#{id}-#{slug}"
  end

  def self.search(search)
    if search
      where("product_name LIKE ?", "%#{search}%")
    else
      all
    end
  end

  private
    def magic
      Shortener::ShortenedUrl.generate("/products/#{self.id}", owner: self)
      self.save!
    end
end
