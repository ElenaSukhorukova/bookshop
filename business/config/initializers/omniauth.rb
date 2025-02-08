Rails.application.config.middleware.use OmniAuth::Builder do
  google_configs = Rails.application.credentials.config[:google]

  provider :google_oauth2, google_configs[:client_id], google_configs[:client_secret]
end
