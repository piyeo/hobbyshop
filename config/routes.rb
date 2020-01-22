Rails.application.routes.draw do
  root 'items#index'

  get  '/signup' => 'users#new'
  post  '/signup' => 'users#create'
  get    '/login' => 'sessions#new'
  post   '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get    '/login_admin' => 'admins#new'
  post   '/login_admin' => 'admins#create'
  delete '/logout_admin' => 'admins#destroy'
  get  '/account/edit' => 'accounts#edit'
  patch  '/account' => 'accounts#update'
  delete  '/account' => 'accounts#destroy'

  resources :items, only: [:index, :show] do
    get "search", on: :collection
  end
  resources :users
  resources :reviews
  resources :orders, only: [:new, :create,:index, :show,:update]
  resource :account, only: [:show, :edit, :update]
  resource :cart do
    get "add", on: :member #カートの追加
  end

  namespace :admin do
    root "top#index"
    resources :items do
      get "search", on: :collection
    end
    resources :reviews, only: [:destroy,:index]
    resources :orders
    post 'items/new' => 'items#create'
    patch 'items/:id/edit' => 'items#update'
  end
end
