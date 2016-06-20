Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations'
  }

  resources :products
  resources :users, :path => 'stores', :only => [:show]
  
  get '/:id' => "shortener/shortened_urls#show"
  get 'catalog/view'
  get 'home/index'
  get 'legal/privacy_policy'
  get 'users/dashboard'
  get 'tutorial/index'
  post 'products/new'

end
