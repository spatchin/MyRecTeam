Rails.application.routes.draw do
  resources :teams
  resources :games

  devise_for :users
  resources :users do
    get :profile, on: :member
  end
  root to: 'pages#home'
end
