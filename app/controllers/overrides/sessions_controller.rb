# Module that handle Overrides. More information at:
# https://github.com/lynndylanhurley/devise_token_auth#custom-controller-overrides
module Overrides
  # This class is a monkeypatch of SessionsController
  class SessionsController < DeviseTokenAuth::SessionsController
    # This method render a json object that informs about the
    # successfully creation of a session.
    #
    # == Returns:
    # json object
    #
    def render_create_success
      render 'api/users/success.json'
    end
  end
end
