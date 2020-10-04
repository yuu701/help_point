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
  end
  
  namespace :children do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :requests
  end
  
  resources :helps
  resources :requests
  resources :applies
  
  resources :parents
  resources :children
  resources :icons
end
