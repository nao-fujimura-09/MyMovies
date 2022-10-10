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
    resources :movies, only: [:index, :show]
    resources :genres, only: [:index]
    resources :movies, only: [:show, :edit, :comfirm]
  end
  
  namespace :public do
  # scope module: :public do
    resources :user, only: [:show, :edit, :comfirm]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
