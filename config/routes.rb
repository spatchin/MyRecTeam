Rails.application.routes.draw do
  resources :teams do
  	get :edit_roster, on: :member
  	patch :update_roster, on: :member
  end
  resources :games

  devise_for :users
  resources :users do
    get :profile, on: :member
  end
  root to: 'pages#home'
end
