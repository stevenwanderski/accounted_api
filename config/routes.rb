AccountedApi::Application.routes.draw do

  namespace :api, defaults: { format: :json} do
    match 'clients', to: 'clients#index', via: [:options]
    match 'clients/:id', to: 'clients#show', via: [:options]
    resources :clients
  end
end
