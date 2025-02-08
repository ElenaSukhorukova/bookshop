require 'rails_helper'

RSpec.describe 'Sessions', type: :feature do
  include_context 'when activated user is present'
  include_context 'when it needs an email and password'

  describe 'new' do
    it 'checks an error message' do
      visit signin_path(locale: 'en')

      expect(page).to have_content I18n.t('views.sessions.new.title')

      within('#new_session') do
        fill_in I18n.t('views.forms.email'), with: email
        fill_in I18n.t('views.forms.password'), with: password
        check I18n.t('views.forms.remember_me')
      end

      click_button 'Create Session'

      expect(page).to have_content I18n.t('errors.invalid_password_or_email')
    end

    it 'checks redirection and flash' do
      visit signin_path(locale: 'en')

      within('#new_session') do
        fill_in I18n.t('views.forms.email'), with: user.email
        fill_in I18n.t('views.forms.password'), with: user.password
        check I18n.t('views.forms.remember_me')
      end

      click_button 'Create Session'

      expect(page).to have_content I18n.t('operations.authentication_process.successful_enter')
    end

    it 'checks reset password link' do
      visit signin_path(locale: 'en')

      find_link(I18n.t('views.sessions.new.link')).click

      expect(page).to have_content I18n.t('views.password_resets.new.title')
    end
  end
end
