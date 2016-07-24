require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable

  after_filter :set_header
  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    # message = client.messages.create from: '+12513016556', to: '+573155533098', body: 'Hola, Acabas de comprar un -Nino el perro- en catlog.co!!!'
    name = 'Sir Alexander De La Muralla'
    message = client.messages.create from: '+12513016556', to: '+573158946059', body: "Hola #{name.truncate(17)}, Acabas de comprar 1 *Nino el perro* de *Tienda x24 sr* en catlog.co. Por aquí te contaremos sobre el estado de tu orden, actualmente: En Proceso." # , status_callback: request.base_url + '/twilio/status'

    render plain: message.status
  end

  def status
    # the status can be found in params['MessageStatus']
    # send back an empty response
    render_twiml Twilio::TwiML::Response.new
  end
end
