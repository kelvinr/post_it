PostitTemplate::Application.routes.draw do
  root 'posts#index'

  get '/register'  => 'users#new'
  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  get '/logout'    => 'sessions#destroy'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end
  resources :categories, only: [:new, :create, :show]
  resources :users, only: :create
end
