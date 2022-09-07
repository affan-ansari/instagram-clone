Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments, except: %i[show index]
  end
  resources :stories, except: %i[edit update]
  resources :users, only: %i[show index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
