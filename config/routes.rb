Rails.application.routes.draw do
  
  get 'applies/new'
  get 'applies/index'
  root 'pages#index'
  
  # namespace :admin do
  #   get '/login',    to: 'sessions#new'
  #   post '/login',   to: 'sessions#create'
  #   delete '/logout', to: 'sessions#destroy'
  # end
  
  namespace :parents do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :requests
    resources :applies, only: [:index, :destroy]
  end
  
  namespace :children do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :requests, only: [:index]
    resources :applies
  end
  
  resources :results
  resources :helps
  resources :parents
  resources :children
  resources :icons
end
