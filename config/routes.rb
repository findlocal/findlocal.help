Rails.application.routes.draw do
  devise_for :users # DON'T REMOVE, user routes are managed by devise!

  # TODO: all the main routes we need in our app
  # e.g. resources :tasks, only: [ :index ]
end
