Rails.application.routes.draw do
  get 'requests/new'

  devise_for :users

  resources :mysteries do
    resources :requests, except: [:index, :show]
  end

  post '/mysteries/:id/join', to: 'mysteries#join', as: 'join_mystery'
  delete '/mysteries/:id/leave', to: 'mysteries#leave', as: 'leave_mystery'
  post '/mysteries/:id/publish', to: 'mysteries#publish', as: 'publish_mystery'
  post '/mysteries/:id/unpublish', to: 'mysteries#unpublish', as: 'unpublish_mystery'
  get '/my_mysteries', to: 'mysteries#my_mysteries', as: 'my_mysteries'

  root 'static_pages#index'
end
