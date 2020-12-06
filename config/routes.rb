Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'searchs#search'
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users, only: [:show, :edit, :update]do
    member do
      get :following, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
