require 'rails_helper'

RSpec.describe Users::InitiateActivation do
  let(:user) { create(:user) }

  describe '#call' do
    it 'initiate activation of a user successfully' do
      described_class.call(user: user)

      expect(user.reload.activation_digest.present?).to be(true)
    end

    it 'validates user\'s presence' do
      operation = described_class.call(user: nil)

      expect(operation.data[:msg]).to include(I18n.t('errors.uncatched_error'))
    end
  end
end
