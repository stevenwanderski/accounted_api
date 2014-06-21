AccountedApi::Application.routes.draw do
  namespace :api, defaults: { format: :json} do
    resources :clients
  end
end
