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
#

class Order < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :product
  belongs_to :store
  belongs_to :customer

  validate :status_is_valid

  def status_is_valid
    valid = [
      'En Proceso',
      'Listo Para Enviar',
      'Enviado',
      'Entregado'
    ].include? self.status
    unless valid
      errors.add(:status, "Estado no permitido")
    end
  end

end
