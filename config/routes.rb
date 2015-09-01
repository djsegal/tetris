Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'games#index'

  resources :games

  get 'players/:game_id/next_piece' => 'players#next_piece'
  get 'players/:game_id/hold_piece' => 'players#hold_piece'
  get 'players/:game_id/game_over'  => 'players#game_over'

end
