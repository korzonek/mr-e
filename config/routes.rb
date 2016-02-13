Rails.application.routes.draw do
  devise_for :users

  resources :mysteries

  post '/mysteries/:id/join', to: 'mysteries#join', as: 'join_mystery'
  delete '/mysteries/:id/leave', to: 'mysteries#leave', as: 'leave_mystery'
  post '/mysteries/:id/publish', to: 'mysteries#publish', as: 'publish_mystery'
  post '/mysteries/:id/unpublish', to: 'mysteries#unpublish', as: 'unpublish_mystery'

  root 'static_pages#index'
end
