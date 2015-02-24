PostitTemplate::Application.routes.draw do
  root 'posts#index'

  get '/register'  => 'users#new'
  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  get '/logout'    => 'sessions#destroy'

  resources :posts, except: :destroy do
    member do 
      post 'vote'
    end
    resources :comments, only: :create do
      member do
        post 'vote'
      end
    end
  end
  

  resources :categories, only: [:new, :create, :show]
  resources :users, except: :destroy
end

# POST /votes => votes#create
#   - need 2 pieces of info

# POST /posts/3/vote => posts#vote
# POST /posts/3/comments/3/vote => comments#vote