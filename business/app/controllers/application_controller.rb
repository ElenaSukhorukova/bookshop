class ApplicationController < ActionController::Base
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html#method-i-protect_from_forgery
  # Turn on request forgery protection. Bear in mind that GET and HEAD requests are not checked.
  protect_from_forgery

  include LocaleConfigs
  include Redirectable

  around_action :set_locale

  # the default alert and notice
  add_flash_types :success, :danger, :info

  private

  def set_locale(&action)
    locale   = current_user.try(:locale)
    locale ||= params[:locale]
    locale ||= find_out_locale
    locale ||= I18n.default_locale

    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
