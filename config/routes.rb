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
  get 'stores/dashboard'
  get 'stores/dashboard/orders', to: 'stores#orders', as: 'store_dashboard_orders'
  get 'stores/list'
  get 'stores/liked'
  get "stores/suscribe"
  get 'store/:id', to: 'stores#show', as: 'store'
  get 'customers/dashboard'
  get 'customers/list'
  get 'customers/dashboard/orders', to: 'customers#orders', as: 'customer_dashboard_orders'
  
  post 'products/new'
  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/notify' => 'twilio#notify'
  post 'twilio/status' => 'twilio#status'

end
