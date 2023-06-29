Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index]
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
