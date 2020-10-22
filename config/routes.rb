Rails.application.routes.draw do
  root 'static_pages#home', as: 'home'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index]
  resources :projects, except: [:index] do 
    resources :tasks, except: [:index]
    defaults format: :json do
      resources :tasks, only: [:index]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
