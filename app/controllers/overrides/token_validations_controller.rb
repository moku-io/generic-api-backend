# https://github.com/lynndylanhurley/devise_token_auth#custom-controller-overrides

module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    def validate_token
      # @resource will have been set by set_user_by_token concern
      if @resource
        render 'api/users/success.json'
      else
        render json: {
          success: false,
          errors: ['Invalid login credentials']
        }, status: :unauthorized
      end
    end
  end
end
