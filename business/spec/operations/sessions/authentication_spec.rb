require 'rails_helper'

RSpec.describe Sessions::Authentication do
  include_context 'when activated user is present'

  let(:session) { Session.new(uid: SecureRandom.uuid, user_id: user.id) }

  let(:params) do |ex|
    password = ex.metadata[:password] || user.password

    {
      session: session,
      password: password,
      remember_me: '1'
    }
  end

  describe '#call' do
    describe 'success process' do
      before do
        allow(user).to receive(:authenticate).and_return(true)
      end

      it 'saved session successfully' do
        operation = described_class.call(params)

        expect(operation.data[:session].persisted?).to be(true)
      end
    end

    it 'validates blank session' do
      params.merge!(session: nil)

      operation = described_class.call(params)

      expect(operation.data[:msg]).to include(I18n.t('errors.uncatched_error'))
    end

    it 'validates a wrong password', password: 'Ol12&*ola19' do
      operation = described_class.call(params)

      expect(operation.type).to be(:unauthorized)
      expect(operation.data[:msg]).to include(I18n.t('errors.invalid_password_or_email'))
    end
  end
end
