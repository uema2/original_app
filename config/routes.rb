Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :clips
    end
  end
  
  resources :hobbies
  resources :clips, only: [:create, :destroy]
  
  mount ActionCable.server => '/cable'
end
