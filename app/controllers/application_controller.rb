class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_filter :set_locale
  before_action :set_client_info


  ## TOKEN AUTH (FROM: http://www.soryy.com/blog/2014/apis-with-devise/)
  def authenticate_user_from_token!
    user_email = request.headers["X-API-EMAIL"].presence        # If it's needed check on USERNAME in place of EMAIL show changes on commit beacon-backend/92f6c98  -  https://bitbucket.org/micred/beacon-backend/commits/92f6c9853f2051fc36561a68e6d4473c0a598642
    user_auth_token = request.headers["X-API-TOKEN"].presence
    user = user_email && User.find(email: user_email)
    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
      sign_in(user, store: false)
    end
  end

  #TODO: Change to reflect format and uncomment check_authorization
  # Fix for CanCan/Strong Parameters (expecting format ex: /api/v1/resource)
  after_filter do
    resource = controller_path.singularize.gsub(/api\/v[\d]+\//i, '').gsub('/', '_')
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # Enable CanCan authorization by default
  # check_authorization unless: :devise_controller?


  private
   def set_locale
     begin
       I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first unless request.env['HTTP_ACCEPT_LANGUAGE'].nil?
     rescue
       logger.error 'Invalid locale. HTTP_ACCEPT_LANGUAGE = ' + request.env['HTTP_ACCEPT_LANGUAGE'].to_s
     end
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
