Rails.application.routes.draw do
  get 'children/new'
  get 'children/index'
  get 'childs/new'
  get 'sessions/new'
  root 'pages#index'
  
  resources :parents
  resources :icons
  
  namespace :parents do
    resources :children
  end
  
  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
