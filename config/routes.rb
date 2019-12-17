Rails.application.routes.draw do

  root 'application#welcome'
  # resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get '/invoices/unsent', to: 'invoices#unsent', as: 'unsent_invoices'

  resources :accounts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :invoices, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  get '/test', to: 'clients#test'
  post '/test', to: 'clients#test'
  get '/add_field', to: 'invoices#add_field', as: 'add_field'
  post '/add_field', to: 'invoices#add_field'

  get '/invoices/accept/:id', to: 'invoices#accept', as: 'accept_invoice'
  get '/invoices/decline/:id', to: 'invoices#decline', as: 'decline_invoice'
  get '/send_invoice/:id', to: 'invoice_mailer#send_invoice', as: 'send_invoice'
  # resources :accounts, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  #delete '/products/:id', to: 'products#destroy', as: "destroy_product"



  scope :users do
    resources :invoices, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks'}, path_names: { sign_in: 'login', sign_out: 'logout'}

end
