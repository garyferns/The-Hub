Rails.application.routes.draw do

  get 'email/index'

  root 'users#index'
  resources :users, except: [:show, :edit]
  get 'user_profile' => 'users#show'
  get 'edit_user' => 'users#edit'

  resources :weather_reports
  resources :user_sessions
  resources :twitter
  resources :instagram
  get '/auth/:provider/callback', to: 'user_sessions#create'

end
