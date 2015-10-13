Rails.application.routes.draw do

  get 'email/index'

  root 'users#index'
  resources :users
  resources :weather_reports
  resources :user_sessions
end
