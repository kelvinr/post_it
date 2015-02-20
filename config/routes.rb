PostitTemplate::Application.routes.draw do
  root 'posts#index'
  resources :posts, except: :destroy
  resources :categories, only: [:new, :create, :show]
end
