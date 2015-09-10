Rails.application.routes.draw do



  resources :profiles
  resources :posts
  mount Upmin::Engine => '/admin'
    devise_for :users
  resources :users

   get 'posts/:id', to: 'posts#short', :as =>  :short
   get 'author/:author', to: 'posts#author', :as =>  :author_posts
   get '/tagged/:tag', to: 'posts#tag', via: [:get, :post], :as => :tag
   get 'provider/:provider', to: 'posts#provider', :as =>  :provider_posts
  
	
  scope ":id" do
    get '/', to: 'profiles#show', :as =>  :vanity_profile
  end

   get '/:user_id/:id', to: 'posts#show', :as =>  :user_post


  root to: 'posts#index'

end
