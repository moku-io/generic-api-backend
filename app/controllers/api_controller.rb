class APIController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  before_action :set_locale
  before_action :set_client_info

  private

  def set_locale
    unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  rescue
    logger.error 'Invalid locale. HTTP_ACCEPT_LANGUAGE = ' + request.env['HTTP_ACCEPT_LANGUAGE'].to_s
  end

  def set_client_info
    @client_platform = @client_version = nil
    begin
      if request.headers['Client-Version'].present?
        @client_platform, @client_version = request.headers['Client-Version'].split('/')
      end
    rescue
      logger.error 'Bad Client-Version header provided by client: ' + request.env['Client-Version']
    end
  end
end
