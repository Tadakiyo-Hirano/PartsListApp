Rails.application.routes.draw do

  root 'home#index'
  # get 'users/show'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  # rootをログイン画面に設定
  # devise_scope :user do
  #   root "users/sessions#new"
  # end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: %i(show)

  resources :brands, except: :destroy do
    post :sort
    collection do
      get :index_sort
      delete :destroy_all
    end
  end

  resources :categories, except: :destroy do
    post :sort
    collection do
      get :index_sort
      delete :destroy_all
    end
  end

  resources :products
end
