Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'pages#home'
  
  #the pages/home url will go to the pages controller, home action
  get 'pages/home', to: 'pages#home'
  get 'pages/about', to: 'pages#about'
  
  get '/tips', to: 'tips#index'
  get '/tips/:id', to: 'tips#show', as: 'tip'
  
end
