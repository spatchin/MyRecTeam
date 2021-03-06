Rails.application.routes.draw do
  get '/members/accept_invite/', to: 'members#accept_invite', as: 'accept_invite_members'
  get '/members/deny_invite/', to: 'members#deny_invite', as: 'deny_invite_members'

  patch '/user_attendances/:id/attend', to: 'user_attendances#attend', as: 'attend_user_attendances'
  patch '/user_attendances/:id/absent', to: 'user_attendances#absent', as: 'absent_user_attendances'
  get '/user_attendances/set_attendance', to: 'user_attendances#set_attendance', as: 'set_user_attendance'

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
  resources :users

  get '/:username', to: 'users#profile', as: 'user_profile'
  root to: 'pages#home'
end
