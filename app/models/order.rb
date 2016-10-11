# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  status         :string
#  total          :integer
#  product_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer
#  store_id       :integer
#  payment_method :string
#  details        :text
#  address        :string
#  city           :string
#

class Order < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :product
  belongs_to :store
  belongs_to :customer

  validate :status_is_valid
  validates_presence_of :total,
                        :product_id,
                        :customer_id,
                        :payment_method

  validates_presence_of :address, if: :need_address
  validates_presence_of :city, if: :need_address

  def product
    Product.with_deleted.find(product_id)
  end

  private
    def status_is_valid
      options =  [
        'En Proceso',
        'Listo Para Enviar',
        'Enviado',
        'Entregado'
      ]
      bank_transfer_data(options)
      valid = options.include? self.status

      unless valid
        errors.add(:status, "Estado no permitido")
      end
    end

    def bank_transfer_data(array)
      if self.payment_method == "Consignación Bancaria"
        array.push('Esperando Consignación')
        array.push('Consignación Recibida')
      end
      if self.payment_method == "Recoger y Pagar en la tienda"
        array.push('Listo para recoger')
      end
    end

    def need_address
      self.payment_method == "Consignación Bancaria" or self.payment_method == "Contra Entrega"
    end

end
