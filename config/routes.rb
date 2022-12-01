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
    resources :users, only: [:index, :show, :edit, :update]
      get "/before_user_select", to: "users#before_user_select", as: "before_user_select"
      get "/:id/users", to: "users#user_select", as: "user_select"
      patch "/withdrawal" => "users#withdrawal", as:"withdrawal"
    resources :movies, only: [:index,:show, :edit, :comfirm] 
      get "/before_movie_select", to: "movies#before_movie_select", as: "before_movie_select"
      get "/:id/movies", to: "movies#movie_select", as: "movie_select"
    resources :genres, only: [:index]
  end
  
  namespace :public do
  # scope module: :public do
    resources :users, only: [:show, :edit, :update] do
      get "/mypage" => "users#mypage", as:"mypage" #マイページの表示
    end
    get "/comfirm" => "users#comfirm", as:"comfirm"
    patch "/withdrawal" => "users#withdrawal", as:"withdrawal"

    resources :follows, only: [:create, :destroy, :followings, :followers]
      get "/follows/followings" => "follows#followings", as:"followings"
      get "/follows/followers" => "follows#followers", as:"followers"
      
    resources :watch_lists, only: [:create, :new, :index, :destroy]
      get "watch_lists/before_watch_select", to: "watch_lists#before_watch_select", as: "before_watch_select"
      get "/:id/watch_lists", to: "watch_lists#watch_select", as: "watch_select"
      
      # get "watch_lists/:id", to: "watch_lists#watch_lists_select", as: "watch_lists_select"
      
    resources :movies, only: [:index, :show, :create] do 
      get 'reviews' => "movies#review", as: "review" #reviewの映画ごとの一覧ページ（reviewのindexでは映画ごとに絞り込めないため）
    end
    resources :reviews, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :views, only: [:create, :destroy]
    resources :genres, only: [:show]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
