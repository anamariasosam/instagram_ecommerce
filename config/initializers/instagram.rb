Instagram.configure do |config|
  config.client_id = "9b7a7c0bb3c24fb6b7ae1cc5b77603c8"
  config.client_secret = "58700887349e44c7b809dc4c61e225c3"
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

CALLBACK_URL = "http://catlog.heroku.com/sessions/callback"