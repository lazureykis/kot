Rails.application.routes.draw do

  root to: 'dungeons#index'

  resources :dungeons do
    collection do
      get :latest
    end

    member do
      post :upvote
      post :downvote
    end
  end

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
