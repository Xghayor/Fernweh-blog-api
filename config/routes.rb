Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  root 'api/v1/users#index', defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        resources :posts, only: [:index, :show, :create, :update, :destroy] do
          resources :comments, only: [:index, :create, :destroy]
          resources :likes, only: [:create, :destroy]
        end
      end
    end
  end
end
