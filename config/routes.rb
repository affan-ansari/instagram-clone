# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :posts do
    resources :comments, except: %i[show index]
  end

  resources :users, only: %i[show index] do
    resources :followings, except: %i[edit show new]
  end

  resources :stories, except: %i[edit update]
  resources :likes, only: %i[create destroy]
end
