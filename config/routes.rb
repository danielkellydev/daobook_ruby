Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :practitioners, controllers: {
    registrations: 'practitioners/registrations'
  }
  resource :practitioner, only: [:show, :edit, :update]
  resources :clients
  resources :provider_numbers
end
