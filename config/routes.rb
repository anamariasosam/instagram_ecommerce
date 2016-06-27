Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations'
  }

  resources :products
  resources :users, :only => [:show], path: "store"
  get 'categories/:id', to: 'categories#show', as: 'category'
  get '/:id' => "shortener/shortened_urls#show"
  get 'catalog/view'
  get 'home/index'
  get 'legal/privacy_policy'
  get 'users/dashboard'
  get 'tutorial/index'
  post 'products/new'

end
