Rails.application.routes.draw do
  resources :users, only: [:create]
  get :users, action: :show, controller: :users
  patch :users, action: :update, controller: :users
  put :users, action: :update, controller: :users

  get 'integer/current', controller: :integer, action: :show
  
  put 'integer/current/:int', controller: :integer, action: :reset
  patch 'integer/current/:int', controller: :integer, action: :reset
    
  patch 'integer/next', controller: :integer, action: :next
  put 'integer/next', controller: :integer, action: :next

  post 'login', controller: :users, action: :login
end
