# Module that handle Overrides. More information at:
# https://github.com/lynndylanhurley/devise_token_auth#custom-controller-overrides

module Overrides
  # This class is a monkeypatch of TokenValidationsController
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    # This method validates the token
    #
    # == Returns:
    # json object which status could be success or unauthorized.
    # In case of unauthorized response, the message 'Invalid login
    # credentials' will be provided.
    #
    def validate_token
      # @resource will have been set by set_user_by_token concern
      if @resource
        render 'api/users/success.json'
      else
        render json: {
          success: false,
          errors: ['Invalid login credentials']
        }, status: 401
      end
    end
  end
end
