Instagram.configure do |config|
  config.client_id = "9b7a7c0bb3c24fb6b7ae1cc5b77603c8"
  config.client_secret = "784947d737dd46f580b804116a2504fa"
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end

CALLBACK_URL = "http://catlog.herokuapp.com/sessions/callback"
