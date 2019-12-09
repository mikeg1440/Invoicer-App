Rails.application.routes.draw do

  root 'application#welcome'
  # resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :accounts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  delete '/accounts/:id', to: 'accounts#destroy'
  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  delete '/products/:id', to: 'products#destroy', as: "destroy_product"
  resources :invoices, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  scope :users do
    resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    devise_for :users, controllers: { omniauth_callbacks: 'callbacks'}, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
  end

  # devise_for :users, controllers: { omniauth_callbacks: 'callbacks'}, path: '', path_names: { sign_in: 'login', sign_out: 'logout'} do
  #   resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
