# ApiController
class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session

  before_action :set_locale
  before_action :set_client_info

  private

  # pay attention to ABC (https://en.wikipedia.org/wiki/ABC_Software_Metric)
  def set_locale
    I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
  rescue
    logger.error 'Invalid locale. HTTP_ACCEPT_LANGUAGE = ' + request.env['HTTP_ACCEPT_LANGUAGE'].to_s
  end

  def set_client_info
    @client_platform = @client_version = nil
    begin
      unless request.headers['Client-Version'].blank?
        @client_platform, @client_version = request.headers['Client-Version'].split('/')
      end
    rescue
      logger.error 'Bad Client-Version header provided by client: ' + request.env['Client-Version']
    end
  end
end
