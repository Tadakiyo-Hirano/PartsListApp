Rails.application.routes.draw do
  resources :categories do
    collection do
      delete 'destroy_all'
    end
  end
end
