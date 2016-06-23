class Product < ActiveRecord::Base
  after_create :magic
  has_shortened_urls
  belongs_to :user
  validates_presence_of :instagram_image,
                        :price,
                        :description,
                        :product_name
  validates_numericality_of :price, :quantity
  validates :price, length: { minimum: 4 }
  validates :description, length: { maximum: 500 }
  validates_length_of :product_name, :maximum => 40

  def to_param
    "#{id}-#{product_name}-#{user.store_name}".parameterize
  end

  private
    def magic
      Shortener::ShortenedUrl.generate("/products/#{self.id}", owner: self)
      self.save!
    end
end
