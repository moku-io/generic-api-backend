Rails.application.routes.draw do

  # Active Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #make devise available for the global scope
  devise_for :users, :skip => [:sessions, :passwords, :registrations]

  namespace :api, defaults: { format: 'json' } do
    # YES. BOTH DEVISES ARE NEEDED
    devise_for :users, :skip => [:passwords, :registrations]



  end

  mount Raddocs::App => '/docs'

  root to: 'admin/dashboard#index'
end
