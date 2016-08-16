module TwilioNotify
  def notify(who, order, first = false)
    store = order.store.name
    customer = order.customer.full_name
    article = order.product.product_name
    status = order.status

    phone = case who
      when 'store'
        order.store.phone_number
      when 'customer'
        order.customer.phone_number
      end

    body = "Hola #{store.truncate(17)}, "

    body += case who
      when "store"
        if first
          "Acabas de vender 1 #{article} a #{customer} en catlog.co; actualiza el estado de la orden en la plataforma;"
        else
          "Acabamos de informar a #{customer} que el artículo #{article} se encuentra"
        end
      when "customer"
        if first
          "Acabas de comprar 1 #{article} de #{store} en catlog.co; por aquí te contaremos sobre el estado de tu orden,"
        else
          "Te contamos que el artículo #{article} se encuentra"
        end
      end

    body += " actualmente: #{status}"

    # client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    # message = client.messages.create from: '+12513016556', to: "+57#{phone}", body: body
  end
end
