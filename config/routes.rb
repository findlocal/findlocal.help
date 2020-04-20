Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users # DON'T REMOVE, user routes are managed by devise!

  resources :tasks, except: [:show] do
    # Everything below is related to a specific task 👇
    resources :helps, only: [:create, :update, :destroy]
    patch "/assign/:helper_id", to: "tasks#assign", as: :assign
  end

  get "/dashboard", to: "tasks#dashboard", as: :dashboard
end
