# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    invitations: 'invitations',
    confirmations: 'users/confirmations',
    passwords: 'users/registrations',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'pages#index'
  get 'about', to: 'pages#about'
  resources :users, only: [:show]
  resources :plans
  resources :boards do
    resources :task_lists, shallow: true do
      resources :tasks, shallow: true
    end
  end
end
