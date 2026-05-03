Rails.application.routes.draw do
  root "posts#index"
  resources :posts, only: [:index, :show]

  namespace :admin do
    root "posts#index"
    resources :posts
  end

  namespace :api do
    resources :posts
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
