Rails.application.routes.draw do

  namespace :public do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/edit'
  end
 root to: "public/homes#top" 
 
  devise_for:users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for:admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :movies, only: [:index, :show]
    resources :genres, only: [:index]
    resources :movies, only: [:show, :edit, :comfirm]
  end
  
  namespace :public do
  # scope module: :public do
    resources :users, only: [:show, :edit, :update, :comfirm]
    # resources :user do
    #   resources :follows, only: [:create, :destroy]
    #   get "followings" => "follows#followings", as:"followings"
    #   get "followers" => "follows#followers", as:"followers"
    # end
    resources :follows, only: [:create, :destroy, :followings, :followers]
      get "/follows/followings" => "follows#followings", as:"followings"
      get "/follows/followers" => "follows#followers", as:"followers"
    resources :watch_lists, only: [:create, :new, :index, :destroy]
    resources :movies, only: [:index, :show, :create]
    resources :reviews, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :views, only: [:create, :destroy]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
