Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users # DON'T REMOVE, user routes are managed by devise!

  resources :tasks, except: [:show] do
    # Everything inside here is related to a specific task
    resources :helps, only: [:create, :update, :destroy]
  end
  resources :tags, only: [:index, :create, :update, :destroy]
end
