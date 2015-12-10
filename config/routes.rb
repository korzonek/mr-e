Rails.application.routes.draw do
  devise_for :users
  get 'static_pages/index'

  root 'static_pages#index'
end
