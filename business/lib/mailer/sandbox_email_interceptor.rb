class Mailer::SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = [ENV['EMAIL_TO_INTERSECT']]
  end
end
