Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users

  resources :streams, only: :show
  resources :tracks
  resources :playlists
  get '/playlists/:id/download' => 'playlists#download', as: :download_playlist
end
