Rails.application.routes.draw do
  devise_for :users

  resources :mysteries

  post '/mysteries/:id/join', to: 'mysteries#join', as: 'join_mystery'
  delete '/mysteries/:id/leave', to: 'mysteries#leave', as: 'leave_mystery'

  root 'static_pages#index'
end
