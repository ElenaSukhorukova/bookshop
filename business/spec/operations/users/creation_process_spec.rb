require 'rails_helper'

RSpec.describe Users::CreationProcess do
  include_context 'when it needs an email and password'

  let(:params) do |ex|
    user_email = ex.metadata[:email] || email
    user_pass = ex.metadata[:email_password] ? email : (ex.metadata[:password] || password)
    password_confirmation = ex.metadata[:password_confirmation] || user_pass
    role = ex.metadata[:role] || 'customer'

    {
      params: {
        email: user_email,
        password: user_pass,
        password_confirmation: password_confirmation,
        role: role
      }
    }
  end

  let(:user) { User.find_by(email: params.dig(:params, :email)) }

  describe '#call' do
    it 'creates a new user successfully' do
      described_class.call(params)

      user = User.find_by(email: params.dig(:params, :email))

      expect(user.present?).to be(true)
      expect(DeletionUnactivatedUserWorker).to have_enqueued_sidekiq_job
    end

    it 'validates blank params' do
      operation = described_class.call({})

      expect(operation.type).to be(:blank_params)
      expect(operation.data[:msg]).to include(I18n.t('errors.blank_params'))
    end

    it 'validates an email format', email: 'wenmorar.example' do
      operation = described_class.call(params)

      expect(user.present?).to be(false)
      expect(operation.type).to be(:invalid_params)
      expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.format'))
    end

    it 'validates a password format', password: '12345678' do
      operation = described_class.call(params)

      expect(user.present?).to be(false)
      expect(operation.type).to be(:invalid_params)
      expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.format'))
    end

    it 'validates password exclusion with email', email_password: true do
      operation = described_class.call(params)

      expect(user.present?).to be(false)
      expect(operation.type).to be(:invalid_params)
      expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.password_exclusion'))
    end

    it 'validates password similarity', password_confirmation: 'wen@morar.example' do
      operation = described_class.call(params)

      expect(user.present?).to be(false)
      expect(operation.type).to be(:invalid_params)
      expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.password_similarity'))
    end

    it 'validates a role', role: 'admin' do
      operation = described_class.call(params)

      expect(user.present?).to be(false)
      expect(operation.type).to be(:invalid_params)
      expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.unsupported_role'))
    end
  end
end
