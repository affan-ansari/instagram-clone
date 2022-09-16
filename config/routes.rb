# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    resources :comments, except: %i[show index]
  end

  resources :users, only: %i[show index] do
    resources :followings, except: %i[edit show new]
  end

  resources :stories, except: %i[edit update]
  resources :likes, only: %i[create destroy]
end
