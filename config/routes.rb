Rails.application.routes.draw do
  resources :users, except: [:index] 
  resource :session, only: [:destroy, :new, :create]
end
