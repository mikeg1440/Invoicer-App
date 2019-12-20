Rails.application.routes.draw do

  root 'application#welcome'

  get '/invoices/unsent', to: 'invoices#unsent', as: 'unsent_invoices'

  resources :accounts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :invoices, only: [:index, :new, :create, :show]
  end

  get '/products/top-five', to: 'products#top_five', as: 'top_five_products'

  resources :invoices, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]


  # routes for adding fields dynamically
  get '/add_field', to: 'invoices#add_field', as: 'add_field'
  post '/add_field', to: 'invoices#add_field'

  # routes for accepting or rejecting a invoice
  get '/invoices/accept/:id', to: 'invoices#accept', as: 'accept_invoice'
  get '/invoices/decline/:id', to: 'invoices#decline', as: 'decline_invoice'
  get '/send_invoice/:id', to: 'invoice_mailer#send_invoice', as: 'send_invoice'

  scope :users do
    resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    # next line will be for clients to view invoices
    # get '/clients/invoices', to: 'clients#invoices', as: 'client_invoices'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks'}, path_names: { sign_in: 'login', sign_out: 'logout'}

end
