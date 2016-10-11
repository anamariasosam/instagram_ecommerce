Rails.application.routes.draw do

  root 'home#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations'
  }

  resources :products, only: [:show] do
    resources :orders do
      # the reference is fall out boy
      get 'thnks_fr_th_mmrs', :on => :collection
    end
  end

  # for the contact form
  resources :contacts, only: [:new, :create]

  namespace :stores do
    resources :products, except: [:show]
    resources :orders, only: [:index, :show, :update]
    get 'dashboard'

    # list with all instagram pictures
    get 'instagram_media'

    # this route provide a form to change payments and delivery info
    get 'payments_and_delivery'
    post 'payments_and_delivery'
  end

  resources :stores, only: [:show], path: 'store'

  get 'customers/dashboard'
  get 'customers/dashboard/orders', to: 'customers#orders'

  get '/:id' => "shortener/shortened_urls#show"
  get 'catalog/view'
  get 'categories/:id', to: 'categories#show', as: 'category'
  get 'home/index'
  get 'legal/privacy_policy'
  get 'users/oauth_failure'

  post 'products/new'
  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/notify' => 'twilio#notify'
  post 'twilio/status' => 'twilio#status'
end
