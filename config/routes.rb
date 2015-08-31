Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'games#new'

  resources :games do
    get 'next_piece', on: :member
    get 'hold_piece', on: :member
  end

end
