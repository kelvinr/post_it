PostitTemplate::Application.routes.draw do
  root 'posts#index'

  get '/register'  => 'users#new'
  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  get '/logout'    => 'sessions#destroy'
  get '/pin'       => 'sessions#pin'
  post '/pin'      => 'sessions#pin'

  # Handle html response for voting
  get '/posts/:id/vote' => 'posts#vote'
  get '/posts/:post_id/comments/:id/vote' => 'comments#vote'

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
  resources :users, only: [:show, :create, :edit, :update]
end