Rails.application.routes.draw do
get 'stores/show'
get 'stores/index'
devise_for :users, :controllers => { registrations: 'registrations' }
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
