class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, only: proc { |c| c.request.format.json? } # Temp solution: https://github.com/lynndylanhurley/devise_token_auth/issues/398

  before_action :set_locale

  private

  def set_locale
    unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  rescue
    logger.error 'Invalid locale. HTTP_ACCEPT_LANGUAGE = ' + request.env['HTTP_ACCEPT_LANGUAGE'].to_s
  end
end
