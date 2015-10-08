Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', confirmations: 'confirmations' }

  resources :applications
  resources :organizations
  root 'applications#index'
end
