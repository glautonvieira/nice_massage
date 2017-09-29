OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :google_oauth2, 'TOKEN', 'KEY',  {scope: 'email', skip_jwt: true}, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :google_oauth2, "TOKEN", "KEY", { :skip_jwt => true }
end
