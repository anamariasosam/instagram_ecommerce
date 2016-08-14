Rails.application.routes.draw do

  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations'
  }

  resources :products do
    resources :orders do
      # the reference is fall out boy
      get 'thnks_fr_th_mmrs', :on => :collection
    end

  end

  resources :contacts, only: [:new, :create]

  get 'categories/:id', to: 'categories#show', as: 'category'
  get '/:id' => "shortener/shortened_urls#show"
  get 'users/oauth_failure'
  get 'catalog/view'
  get 'home/index'
  get 'legal/privacy_policy'

  namespace :stores do
    resources :orders, only: [:index, :show]
    get 'dashboard'
    get 'list'
    get 'liked'
    get 'suscribe'
    get ':id', to: 'stores#show', as: 'store'
  end

  get 'customers/dashboard'
  get 'customers/dashboard/orders', to: 'customers#orders'

  post 'products/new'
  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/notify' => 'twilio#notify'
  post 'twilio/status' => 'twilio#status'
end
