Rails.application.routes.draw do
  get 'products/index'
  resources :categories, except: :destroy do
    post :sort
    collection do
      get :index_sort
      delete :destroy_all
    end
  end

  resources :brands, except: :destroy do
    post :sort
    collection do
      get :index_sort
      delete :destroy_all
    end
  end
end
