Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'pages#home'
  
  #the pages/home url will go to the pages controller, home action
  get 'pages/home', to: 'pages#home'
  get 'pages/about', to: 'pages#about'
  
  resources :tips do
    resources :comments, only: [:create]
    member do 
    post 'like'
  end
  end
    #get '/tips', to: 'tips#index'
    #get '/tips/new', to: 'tips#new', as:'new_tip'
    #get '/tips/:id', to: 'tips#show', as: 'tip'
    #post '/tips', to: 'tips#create'
    
    get '/signup', to: 'members#new'
    resources :members, except: [:new]
    
    #Login / Lgout routes
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    
    resources :skills, except: [:delete]
    
    mount ActionCable.server => '/cable'
    
    get '/chat', to: 'chatrooms#show'
    
    resources :messages, only: [:create]
  
end
