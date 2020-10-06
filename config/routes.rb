Rails.application.routes.draw do
  root 'static_pages#home', as: 'home'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create', as: 'new_session'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index] 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
