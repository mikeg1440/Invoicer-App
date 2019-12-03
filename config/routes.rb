Rails.application.routes.draw do

  # get 'accounts/index'
  # get 'accounts/show'
  # get 'accounts/new'
  # get 'accounts/edit'
  # get 'clients/index'
  # get 'clients/show'
  # get 'clients/new'
  # get 'clients/edit'

  root 'application#welcome'
  resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :accounts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
