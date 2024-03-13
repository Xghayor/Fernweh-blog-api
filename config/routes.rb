Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'api/v1/users#profile', defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :update] do
        post :add_image, on: :member
      end
      resources :posts, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:create, :destroy]
        resources :likes, only: [:create, :destroy]
      end
    end
  end
end
