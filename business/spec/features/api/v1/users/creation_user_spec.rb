require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  include_context 'when it needs an email and password'

  describe 'new' do
    it 'checks an error message' do
      visit new_user_path(locale: 'en')

      expect(page).to have_content I18n.t('views.users.new.title')

      within('#new_user') do
        fill_in I18n.t('views.forms.email'), with: email
        fill_in I18n.t('views.forms.password'), with: email
        fill_in I18n.t('views.forms.password_confirmation'), with: email
      end

      click_button 'Create User'

      expect(page).to have_content I18n.t('dry_validation.errors.password_exclusion')
    end

    it 'checks redirection and flash' do
      visit new_user_path(locale: 'en')

      within('#new_user') do
        fill_in I18n.t('views.forms.email'), with: email
        fill_in I18n.t('views.forms.password'), with: password
        fill_in I18n.t('views.forms.password_confirmation'), with: password
      end

      click_button 'Create User'

      expect(page).to have_content I18n.t('operations.created_user.check_email')
    end
  end
end
