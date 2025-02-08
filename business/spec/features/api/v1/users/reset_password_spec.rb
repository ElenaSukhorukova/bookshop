require 'rails_helper'

RSpec.describe 'ResetPassword', type: :feature do
  include_context 'when activated user is present'
  include_context 'when it needs an email and password'

  let(:token) do
    'eyJfcmFpbHMiOnsiZGF0YSI6WzE4LCJHbFdZZ1dObC91Il0sImV'\
    '4cCI6IjIwMjQtMTItMTVUMDc6NDk6MTYuNDcyWiIsInB1ciI6IlV'\
    'zZXJcbnJlc2V0X3Rva2VuXG45MDAifX0=--46ae1ac6cb5297cbf'\
    'd3e04a2f511c2de8081b70f'
  end

  let(:params) do
    {
      id: token,
      locale: 'en',
      email: user.email
    }
  end

  describe 'new' do
    it 'checks an error message' do
      visit new_password_reset_path(locale: 'en')

      expect(page).to have_content I18n.t('views.password_resets.new.title')

      within('#password_reset') do
        fill_in I18n.t('views.forms.email'), with: email
      end
      click_button I18n.t('views.password_resets.new.submit')

      expect(page).to have_content I18n.t('errors.invalid_email')
    end

    it 'checks redirection and flash' do
      visit new_password_reset_path(locale: 'en')

      within('#password_reset') do
        fill_in I18n.t('views.forms.email'), with: user.email
      end
      click_button I18n.t('views.password_resets.new.submit')

      expect(page).to have_content I18n.t('operations.initiate_password_reset.check_email')
    end
  end

  describe '#edit' do
    before do
      allow(User).to receive(:find_by_token_for).with(:reset_token, token).and_return(user)
      allow(User).to receive(:find_by).with(email: user.email).and_return(user)

      allow(user).to receive(:authenticated?).with(:reset, token).and_return(true)
    end

    it 'checks success flash' do
      visit edit_password_reset_url(params)

      within('#edit_password') do
        fill_in I18n.t('views.forms.password'), with: password
        fill_in I18n.t('views.forms.password_confirmation'), with: password
      end

      click_button I18n.t('views.password_resets.edit.submit')

      expect(page).to have_content I18n.t('operations.updation.password_reset')
    end
  end
end
