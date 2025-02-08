Rails.application.configure do
  config.action_mailer.interceptors = %w[Mailer::SandboxEmailInterceptor] if Rails.env.development?
end
