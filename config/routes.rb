Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show] do
    member do
      post "friend" => "friend_users#create"
    end
  end

  # Defines the root path route ("/")
  root "users#index"
end
