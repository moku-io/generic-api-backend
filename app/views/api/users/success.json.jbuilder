# https://github.com/lynndylanhurley/devise_token_auth/issues/567

json.data do
  json.partial! 'api/users/user', user: @resource
end
