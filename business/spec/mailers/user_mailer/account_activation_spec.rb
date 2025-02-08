require 'rails_helper'

RSpec.describe UserMailer, '#account_activation' do
  include_context 'when testing of a mailer'

  let(:user) { create(:user) }
  let(:email) { described_class.with(user: user).account_activation }

  before do
    user.create_activate_digest
  end

  it 'delivers to the user\'s email' do
    expect(email).to deliver_to(user.email)
  end

  it 'contains an activation_token' do
    expect(email).to have_body_text($redis.get("#{user.id}_activation_token"))
  end

  it 'has a correct subject' do
    expect(email).to have_subject(I18n.t('user_mailer.account_activation.subject'))
  end
end
