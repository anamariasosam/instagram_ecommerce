Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: 'registrations'
  }

  resources :products

  get '/:id' => "shortener/shortened_urls#show"
  get 'catalog/view'
  get 'home/index'
  get 'legal/privacy_policy'
  get 'stores/index'
  get 'stores/show'
  get 'users/dashboard'

  post 'products/new'

end
