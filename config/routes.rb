Rails.application.routes.draw do
  devise_for :users

  resources :streams, only: :show
  resources :tracks
end
