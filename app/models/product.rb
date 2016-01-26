class Product < ActiveRecord::Base
  after_create :magic
  has_shortened_urls
  belongs_to :user
  validates_presence_of :instagram_image,
                        :price,
                        :description,
                        :product_name
  validates_numericality_of :price, :quantity
  private
    def magic
      Shortener::ShortenedUrl.generate("/products/#{self.id}", owner: self)
      self.save!
    end
end
