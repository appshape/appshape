Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', confirmations: 'confirmations' }

  resources :applications
  resources :organizations
  resources :http_headers, only: :index
  resources :tests do
    member do
      patch :toggle
      get :run
    end
  end

  root 'applications#index'
end
