# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments, except: %i[show index]
  end
  resources :stories, except: %i[edit update]
  resources :users, only: %i[show index]
  resources :likes, only: %i[create destroy]
  resources :followings, only: %i[create destroy]
end
