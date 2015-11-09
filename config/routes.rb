Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', confirmations: 'confirmations' }

  resources :organizations do
    resources :projects, controller: 'organizations/projects'
  end

  resources :http_headers, only: :index
  resources :tests do
    member do
      patch :toggle
      get :run
    end
  end

  root 'applications#index'
end
