Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        member do
          get 'posts', to: 'users#posts'
          get 'comments', to: 'users#comments'
          post 'comments/:post_id', to: 'users#add_comment', as: 'add_comment'
        end
      end
      resources :posts, only: [] do
        resources :comments, only: [:index, :create]
        resources :likes, only: [:create]
      end
    end
  end

  root "users#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
