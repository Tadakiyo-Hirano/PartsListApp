Rails.application.routes.draw do
  resources :categories do
    post :sort
    collection do
      delete :destroy_all
    end
  end
end
