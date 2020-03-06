# https://github.com/lynndylanhurley/devise_token_auth#custom-controller-overrides

module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def render_create_success
      render 'api/users/success.json'
    end
  end
end
