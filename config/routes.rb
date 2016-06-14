Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount_devise_token_auth_for 'User', at: 'api/auth'

  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: 'json' } do
    # make devise available for the global scope (confirmable, password resets...)
    # devise_for :users, :skip => [:sessions, :passwords, :registrations]

    # resources :users, only: [:show, :update]


  end

  mount Raddocs::App => '/docs'

  root to: 'admin/dashboard#index'
end
