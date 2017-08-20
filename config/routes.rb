Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root 'application#list'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
  	member do
      get :block
      get :unblock
      get :delete
  	end
  end
end
