class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  def default_url_options
    { locale: I18n.locale }
  end
end
