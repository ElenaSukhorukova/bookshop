require 'rails_helper'

RSpec.describe Users::Updation do
  include_context 'when activated user is present'
  include_context 'when it needs an email and password'

  let(:params) do |ex|
    user_email = ex.metadata[:invalid_email] ? email : user.email
    user_password =
      if ex.metadata[:invalid_password]
        '123456789'
      else
        ex.metadata[:pass_eq_email] ? user.email : password
      end

    confirm_pass = ex.metadata[:invalid_confirm_password] ? user.password : password

    {
      email: user_email,
      password: user_password,
      password_confirmation: confirm_pass,
      id: $redis.get("#{user.id}_reset_token")
    }
  end

  before do
    user.create_reset_digest
  end

  describe 'success pocess' do
    before do
      allow(user).to receive(:authenticated?).with(:reset, params[:id]).and_return(true)
    end

    it 'creates new session successfully' do
      operation = described_class.call(params: params)

      expect(operation.data[:msg]).to include(I18n.t('operations.updation.password_reset'))
    end
  end

  it 'validates blank params' do
    operation = described_class.call({})

    expect(operation.data[:msg]).to include(I18n.t('errors.blank_params'))
    expect(operation.type).to be(:blank_params)
  end

  it 'validates an email', invalid_email: true do
    operation = described_class.call(params: params)

    expect(operation.data[:msg]).to include(I18n.t('errors.invalid_email'))
    expect(operation.type).to be(:invalid_params)
  end

  it 'validates a wrong password', invalid_password: true do
    operation = described_class.call(params: params)

    expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.format'))
    expect(operation.type).to be(:invalid_params)
  end

  it 'validates password_similarity', invalid_confirm_password: true do
    operation = described_class.call(params: params)

    expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.password_similarity'))
  end

  it 'validates password_exclusion', pass_eq_email: true do
    operation = described_class.call(params: params)

    expect(operation.data[:msg]).to include(I18n.t('dry_validation.errors.password_exclusion'))
  end
end
