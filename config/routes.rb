Rails.application.routes.draw do
  resources :users, except: [:index] 
  resource :session, only: [:destroy, :new, :create]
  resources :subs, except: [:destroy]
  resources :posts, except: [:destroy, :index]
end
