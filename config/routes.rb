Rails.application.routes.draw do
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'personas/index'
  end
  namespace :users_backoffice do
    get 'documents/index'
  end
  namespace :users_backoffice do
    get 'contracts/index'
  end
  namespace :users_backoffice do
    get 'comments/index'
  end
  namespace :users_backoffice do
    get 'users/index'
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
