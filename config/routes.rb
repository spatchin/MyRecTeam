Rails.application.routes.draw do
  get '/members/accept_invite/', to: 'members#accept_invite', as: 'accept_invite_members'
  get '/members/deny_invite/', to: 'members#deny_invite', as: 'deny_invite_members'

  resources :teams do
  	get :edit_roster, on: :member
  	patch :update_roster, on: :member
    post :remove_player, on: :member
    post :add_player, on: :member
  end
  resources :games

  devise_for :users
  resources :users do
    get :profile, on: :member
  end
  root to: 'pages#home'
end
