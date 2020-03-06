Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount_devise_token_auth_for 'User', at: 'api/auth', controllers: {
    token_validations: 'overrides/token_validations',
    sessions: 'overrides/sessions'
  }

  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: 'json' } do
    # make devise available for the global scope (confirmable, password resets...)
    # devise_for :users, :skip => [:sessions, :passwords, :registrations]

    # resources :users, only: [:show, :update]
  end

  # If authenticated, show the docs.
  authenticated :admin_user do
    mount Apitome::Engine => '/docs'
  end
  # If not authenticated, redirect to login.
  get 'docs', to: 'admin/dashboard#index'

  root to: 'admin/dashboard#index'
end
