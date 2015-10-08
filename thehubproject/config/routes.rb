Rails.application.routes.draw do

  root 'users#index'
  resources :users
  resources :weather_reports
  resources :user_sessions
end
