Rails.application.routes.draw do
  root :to => "home#top"
  get "about" => "home#about"
  
  #フォローフォロワー関連
  get "users/:id/following" => "follows#following"
  get "users/:id/followers" => "follows#followers"

  post "follows/:id/create" => "follows#create"
  post "follows/:id/remove" => "follows#remove"

  #users関連
  get "users/index" => "users#index"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  get "users/:id/likes" => "users#likes"

  # posts関連
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"


  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
