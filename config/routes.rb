Rails.application.routes.draw do
  resources :tasks
  root 'blogs#index'
  resources :blogs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
