Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session
  resource :register
  resources :wechats

  resource :user

  resources :products
end
