Rails.application.routes.draw do

  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations'
  }

  resources :products
  resources :contacts, only: [:new, :create]
  resources :orders

  get 'categories/:id', to: 'categories#show', as: 'category'
  get "users/suscribe"
  get 'store/:id', to: 'stores#show', as: 'store'
  get '/:id' => "shortener/shortened_urls#show"
  get 'users/oauth_failure'
  get 'catalog/view'
  get 'home/index'
  get 'legal/privacy_policy'
  get 'users/dashboard'
  get 'users/list'
  get 'users/liked'
  get 'customers/dashboard'

  post 'products/new'

end
