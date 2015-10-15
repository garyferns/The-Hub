Rails.application.routes.draw do

  #get 'oauths/oauth'

  #get 'oauths/callback'

  root 'users#index'
  resources :users, except: [:show, :edit]
  get 'user_profile' => 'users#show'
  get 'edit_user' => 'users#edit'

  resources :weather_reports
  resources :user_sessions
  resources :twitter
  resources :instagram
  #get '/auth/:provider/callback', to: 'user_sessions#create'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

end
