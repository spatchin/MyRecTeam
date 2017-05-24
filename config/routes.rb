Rails.application.routes.draw do
  get '/members/accept_invite/', to: 'members#accept_invite', as: 'accept_invite_members'
  get '/members/deny_invite/', to: 'members#deny_invite', as: 'deny_invite_members'

  patch '/user_attendances/:id/attend', to: 'user_attendances#attend', as: 'attend_user_attendances'
  patch '/user_attendances/:id/absent', to: 'user_attendances#absent', as: 'absent_user_attendances'
  patch '/user_attendances/update_game', to: 'user_attendances#update_from_email', as: 'update_game_reminder'

  resources :teams do
    get :edit_roster, on: :member
    patch :update_roster, on: :member
    post :remove_player, on: :member
    post :add_player, on: :member
  end

  resources :games do
    patch :complete, on: :member
    patch :cancel, on: :member
  end

  resources :comments, only: [:create, :update, :destroy]
  resources :preferences, only: [:show, :create, :update, :destroy]

  devise_for :users
  resources :users do
    get :profile, on: :member
  end

  root to: 'pages#home'
end
