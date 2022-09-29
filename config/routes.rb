# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'pages#index'
  get 'about', to: 'pages#about'
  resources :plans
  resources :boards do
    resources :task_lists, shallow: true do
      resources :tasks, shallow: true
    end
  end
end
