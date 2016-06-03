Rails.application.routes.draw do
get 'stores/show'
get 'stores/index'
devise_for :users, :controllers => { registrations: 'registrations' }
devise_scope :user do
  get "/login" => "devise/sessions#new"
  get "/sign_up" => "registrations#new"
end
get 'legal/privacy_policy'
get 'catalog/view'
get 'home/index'
resources :products
get 'sessions/connect'
get 'sessions/callback'
get 'users/dashboard'
post 'products/new'
get '/:id' => "shortener/shortened_urls#show"
root 'home#index'
end
