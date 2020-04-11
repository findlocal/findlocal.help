Rails.application.routes.draw do

  devise_for :users # DON'T REMOVE, user routes are managed by devise!

  # TODO: all the main routes we need in our app

  root to: 'pages#index'

  resources :tasks, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :task_applications, only: [:index, :create, :destroy]
  end
  resources :tags, only: [:index, :create, :update, :destroy]
  
end
