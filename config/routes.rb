Rails.application.routes.draw do

  root 'home#index'
  # get 'users/show'
  
  # devise_for :admins, controllers: {
  #   sessions: 'admins/sessions'
  # }

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'pladmin/login' => 'admins/sessions#new', as: :new_admin_session
    post 'pladmin/login' => 'admins/sessions#create', as: :admin_session
    delete 'pladmin/logout' => 'admins/sessions#destroy', as: :destroy_admin_session
  end

  namespace :admins do
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
    resources :users
    resources :products
  end

  # rootをログイン画面に設定
  # devise_scope :user do
  #   root "users/sessions#new"
  # end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: %i(show) do
    resources :products, controller: 'users/products'
  end
  resources :products
end
