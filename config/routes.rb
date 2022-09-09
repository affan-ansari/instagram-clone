Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments, except: %i[show index]
  end
<<<<<<< HEAD
  resources :stories, except: %i[edit update]
=======
>>>>>>> a3fcf3cc92ac18753689a709219399f9ae7a750b
  resources :users, only: %i[show index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
