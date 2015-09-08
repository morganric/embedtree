Rails.application.routes.draw do



  resources :profiles
  resources :posts
  mount Upmin::Engine => '/admin'
    devise_for :users
  resources :users
  
	
  scope ":id" do
    get '/', to: 'profiles#show', :as =>  :vanity_profile
  end

   get '/:user_id/:id', to: 'posts#show', :as =>  :user_post

  root to: 'posts#index'

end
