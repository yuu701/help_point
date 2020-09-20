Rails.application.routes.draw do
  
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
  end
  
  namespace :children do
    get '/login',    to: 'sessions#new'
    post '/login',   to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  
  
  
  # get '/login',    to: 'sessions#new'
  # post '/login',   to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  resources :helps do
    resources :requests
  end
  
  resources :children
  resources :parents
  resources :icons
end
