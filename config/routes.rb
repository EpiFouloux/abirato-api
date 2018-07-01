Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, except: :create do
    resources :characters, controller: 'character/instances', only: [:index]
  end

  resources :characters, controller: 'character/instances', except: [:index] do
    resources :events, controller: 'character/events', only: %i[index]
  end

  resources :natures, controller: 'character/natures', only: %i[index show]
  resources :templates, controller: 'character/templates', only: %i[index show]
  resources :classes, controller: 'character/classes', only: %i[index show]

  # Auth
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get '/health', to: 'health#index'
end
