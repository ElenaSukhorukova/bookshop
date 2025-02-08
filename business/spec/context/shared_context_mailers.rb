RSpec.shared_context 'when testing of a mailer' do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include Rails.application.routes.url_helpers
end
