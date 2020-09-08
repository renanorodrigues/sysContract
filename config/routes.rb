Rails.application.routes.draw do

  namespace :users_backoffice do
    get 'welcome/index'
    get 'personas/list/:identification', to: 'personas#show'
    get 'documents/visibility_configuration', to: 'documents#visibility_configuration', as: :visibility_configuration
    
    resources :users
    resources :documents
    resources :personas
    resources :contracts do
      resources :comments
    end
  end
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users_backoffice/welcome#index'
end
