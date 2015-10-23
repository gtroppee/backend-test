Rails.application.routes.draw do
  root 'companies#index'
  resources :calls, only: :index do
    collection do
      post :dial
      post :forward
      post :hangup
    end
  end
end

# http://983a260e.ngrok.io/calls/dial