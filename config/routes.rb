Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'users/:id', to: 'users#show'
  get 'users/:id/posts', to: 'posts#index'
  get 'users/:user_id/posts/:post_id', to: 'posts#show'
  root "users#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
