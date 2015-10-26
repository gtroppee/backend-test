Rails.application.routes.draw do
  root 'companies#index'
  resources :calls, only: :index
  resources :companies, only: :index
  post '/calls/:action' => 'calls#action'
end
