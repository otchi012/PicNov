Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  get 'post_comments/create'
  get 'post_comments/destroy'
  get 'homes/top'
  get 'homes/about'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
