Rails.application.routes.draw do
  root 'companies#index'
  resources :calls, only: :index do
    collection do
      post :dial
      post :voicemail
      post :hangup
    end
  end
  resources :companies, only: :index
end
