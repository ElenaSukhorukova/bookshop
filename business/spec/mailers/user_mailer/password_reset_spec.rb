require 'rails_helper'

RSpec.describe UserMailer, '#password_reset' do
  include_context 'when testing of a mailer'
  include_context 'when activated user is present'

  before do
    user.create_reset_digest
  end

  describe 'process' do
    let(:email) { described_class.with(user: user).password_reset }

    it 'delivers to the user\'s email' do
      expect(email).to deliver_to(user.email)
    end

    it 'contains an activation_token' do
      expect(email).to have_body_text($redis.get("#{user.id}_reset_token"))
    end

    it 'has a correct subject' do
      expect(email).to have_subject(I18n.t('user_mailer.password_reset.subject'))
    end
  end
end
