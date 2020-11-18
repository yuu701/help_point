Rails.application.routes.draw do
  
  root 'pages#index'
  
  namespace :admin do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  
  namespace :parents do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :requests, :helps
    resources :applies, only: [:index, :destroy]
  end
  
  namespace :children do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :requests, :helps, only: [:index]
    resources :applies
  end
  
  resources :results
  resources :parents, except: [:index]
  resources :children
  resources :icons
end
