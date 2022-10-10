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
  get 'free-trial', to: 'pages#free_trial'
  get 'team', to: 'pages#team'
  resources :users, only: [:show]
  resources :payments, only: %i[new create]
  resources :plans
  resources :boards do
    resources :task_lists, shallow: true do
      resources :tasks, shallow: true do
        resources :task_users, only: %i[new create]
      end
    end
  end
  resources :user_plans, only: %i[create destroy]
end
