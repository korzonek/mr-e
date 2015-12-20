Rails.application.routes.draw do
  devise_for :users

  resources :cases

  post '/cases/:id/join', to: 'cases#join', as: 'join_case'
  delete '/cases/:id/leave', to: 'cases#leave', as: 'leave_case'

  root 'static_pages#index'
end
