Rails.application.routes.draw do



  resources :profiles
  resources :posts
  mount Upmin::Engine => '/admin'
    devise_for :users
  resources :users
  
	
  scope ":id" do
    
    get '/', to: 'profiles#show', :as =>  :vanity_profile

  end
  root to: 'posts#index'

end
