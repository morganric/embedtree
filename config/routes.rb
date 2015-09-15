Rails.application.routes.draw do

   # get '/categories', to: 'posts#categories', :as =>  :categories
  get '/latest', to: 'posts#latest', :as =>  :latest 
  get 'tagged/:tag/latest', to: 'posts#tag_latest', :as =>  :tag_latest   
  get '/about', to: 'visitors#index', :as =>  :about 
  get ':id/popular', to: 'profiles#popular', :as =>  :user_popular     
  get ':id/favourites', to: 'profiles#favourites', as: :user_favourites

  resources :profiles
  resources :posts
  mount Upmin::Engine => '/admin'
    devise_for :users
  resources :users

   get '/p/:id', to: 'posts#short', :as =>  :short
   get 'author/:author', to: 'posts#author', :as =>  :author_posts
   get '/tagged/:tag', to: 'posts#tag', via: [:get, :post], :as => :tag
   get 'publisher/:provider', to: 'posts#provider', :as =>  :provider_posts
  
	post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'

  scope ":id" do
    get '/', to: 'profiles#show', :as =>  :vanity_profile
  end

   get '/:user_id/:id', to: 'posts#show', :as =>  :user_post



  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "posts#index"
  end



end
