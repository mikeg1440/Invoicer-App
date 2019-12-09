Rails.application.routes.draw do

  root 'application#welcome'
  resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :accounts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :invoices, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks'}, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  scope :users do
    resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    devise_for :users, controllers: { omniauth_callbacks: 'callbacks'}, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
