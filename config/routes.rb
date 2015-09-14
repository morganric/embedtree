Rails.application.routes.draw do

   # get '/categories', to: 'posts#categories', :as =>  :categories
   get '/latest', to: 'posts#latest', :as =>  :latest 
      get 'tagged/:tag/latest', to: 'posts#tag_latest', :as =>  :tag_latest   
    get '/about', to: 'visitors#index', :as =>  :about 
  get ':id/popular', to: 'profiles#popular', :as =>  :user_popular     

  resources :profiles
  resources :posts
  mount Upmin::Engine => '/admin'
    devise_for :users
  resources :users

   get '/p/:id', to: 'posts#short', :as =>  :short
   get 'author/:author', to: 'posts#author', :as =>  :author_posts
   get '/tagged/:tag', to: 'posts#tag', via: [:get, :post], :as => :tag
   get 'provider/:provider', to: 'posts#provider', :as =>  :provider_posts
  
	
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
