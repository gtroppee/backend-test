Rails.application.routes.draw do
  root 'companies#index'
  resources :calls, only: :index
  resources :companies, only: :index
  match '/calls/:action' => 'calls#action', via: [:post, :get]
end
