class Order < ActiveRecord::Base
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
