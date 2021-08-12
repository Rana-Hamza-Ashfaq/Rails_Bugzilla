Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :bugs
  namespace :api do
    resources :bugs
  end
  resources :projects

  namespace :api do
    resources :projects
  end

  namespace :api do
    resources :user
  end

  root to: 'home#index'
  get 'home/all_dev'
  get 'home/assign_project'
  get 'home/project_users'
  get 'home/remove_project_user'
  get 'home/take_bug'
  get 'home/list_assigned_bugs'
  get 'home/complete_bug'

end
