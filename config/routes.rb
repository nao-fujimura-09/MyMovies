Rails.application.routes.draw do
  
 root to: "public/homes#top" 
 
  devise_for:users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for:admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :users, only: [:index, :show, :edit]
    resources :movies, only: [:index,:show, :edit, :comfirm]
    resources :genres, only: [:index]
  end
  
  namespace :public do
  # scope module: :public do
    resources :users, only: [:show, :edit, :update, :comfirm] do
      get "/mypage" => "users#mypage", as:"mypage" #マイページの表示
    end
    # resources :user do
    #   resources :follows, only: [:create, :destroy]
    #   get "followings" => "follows#followings", as:"followings"
    #   get "followers" => "follows#followers", as:"followers"
    # end
    resources :follows, only: [:create, :destroy, :followings, :followers]
      get "/follows/followings" => "follows#followings", as:"followings"
      get "/follows/followers" => "follows#followers", as:"followers"
    resources :watch_lists, only: [:create, :new, :index, :destroy]
    resources :movies, only: [:index, :show, :create] do 
      get 'reviews' => "movies#review", as: "review" #reviewの映画ごとの一覧ページ（reviewのindexでは映画ごとに絞り込めないため）
    end
    resources :reviews, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :views, only: [:create, :destroy]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
