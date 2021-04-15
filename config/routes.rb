Rails.application.routes.draw do
  get 'users/show'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: %i(show)

  root 'home#index'

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
