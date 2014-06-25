AccountedApi::Application.routes.draw do

  namespace :api, defaults: { format: :json} do
    match 'clients', to: 'clients#index', via: [:options]
    match 'clients/:id', to: 'clients#show', via: [:options]
    match 'payments', to: 'payments#index', via: [:options]
    match 'payments/:id', to: 'payments#show', via: [:options]
    resources :clients
    resources :payments
  end
end
