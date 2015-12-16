Rails.application.routes.draw do
  devise_for :users

  resources :cases

  get 'static_pages/index'

  root 'static_pages#index'
end
