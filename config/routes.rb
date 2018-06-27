Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, except: :create do
    resources :characters, controller: 'character/instances', only: [:index]
  end

  resources :characters, controller: 'character/instances', except: [:index] do
    resources :events, controller: 'character/events'
  end
  resources :natures, controller: 'character/natures', only: [:index, :show]
  resources :templates, controller: 'character/templates', only: [:index, :show]
  resources :classes, controller: 'character/classes', only: [:index, :show]

  # Auth
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get '/health', to: 'health#index'
end
