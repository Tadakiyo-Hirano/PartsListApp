Rails.application.routes.draw do
  resources :categories do
    post :sort
    collection do
      get :index_sort
      delete :destroy_all
    end
  end
end
