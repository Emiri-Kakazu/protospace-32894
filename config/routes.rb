Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'root_path', to: 'prototypes#index'
  root to: 'prototypes#index'
  resources :prototypes, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
