OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :google_oauth2, 'TOKEN', 'KEY',  {scope: 'email', skip_jwt: true}, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  provider :google_oauth2, "487859200397-rvu3kl09ee9d9mbvsjiut8j7pba4km4u.apps.googleusercontent.com", "cpRq7E-Xq51eYMYO4l0rGAoj", { :skip_jwt => true }
end
