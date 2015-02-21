PostitTemplate::Application.routes.draw do
  root 'posts#index'
  resources :posts, except: :destroy do
    resources :comments, only: :create
  end
  resources :categories, only: [:new, :create, :show]
end
