Rails.application.routes.draw do
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
