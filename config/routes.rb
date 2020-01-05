Rails.application.routes.draw do
  root 'items#index'

  get  '/signup' => 'users#new'
  post  '/signup' => 'users#create'
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :items
  resources :users
  resources :account, only: [:show, :edit, :update]
end
