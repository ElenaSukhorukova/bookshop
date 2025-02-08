require 'rails_helper'

RSpec.describe PasswordReset::InitiatePasswordReset do
  include_context 'when activated user is present'

  let(:params) do |ex|
    email = ex.metadata[:email] || user.email

    {
      email: email
    }
  end

  describe '#call' do
    it 'creates reset digest successfully' do
      operation = described_class.call(params: params)

      expect(operation.data[:msg]).to include(I18n.t('operations.initiate_password_reset.check_email'))
      expect(user.reload.reset_digest.present?).to be(true)
    end

    it 'validates blank params' do
      operation = described_class.call({})

      expect(operation.type).to be(:blank_params)
      expect(operation.data[:msg]).to include(I18n.t('errors.blank_params'))
    end

    it 'validates a blank user', email: 'scott@pouros-beahan.example' do
      operation = described_class.call(params: params)

      expect(operation.type).to be(:invalid_params)
      expect(operation.data[:msg]).to include(I18n.t('errors.invalid_email'))
    end

    describe 'unactivated_user' do
      before do
        user.update(activated: false)
      end

      it 'validates an activated user' do
        operation = described_class.call(params: params)

        expect(operation.type).to be(:unactivated_user)
        expect(operation.data[:msg]).to include(I18n.t('errors.unactivated_account'))
      end
    end
  end
end
