Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # root 'home#index'
  
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
    resources :users do
      get 'favorite'
    end
    resources :products
    resources :notices
    resources :contacts
  end

  # rootをログイン画面に設定
  devise_scope :user do
    root "users/sessions#new"
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: %i(show) do
    resources :products, controller: 'users/products' do
      collection do
        get :favorites
      end
      resources :favorites
    end
  end

  resources :admins, only: %i(index)
  resources :products
  resources :notices, only: %i(index)

  # Active StorageのURLを期限付きにする
  # https://github.com/rails/rails/blob/v6.1.3.2/activestorage/config/routes.rb#L60-L81
  # を元に`expires_in`オプションを受け付けるように定義しなおしています
  direct :app_blob do |model, options|
    # 1.hourはデフォルトの有効期限
    expires_in = options.delete(:expires_in) { 1.hour }

    if model.respond_to?(:signed_id)
      route_for(
        :rails_service_blob,
        model.signed_id(expires_in: expires_in),
        model.filename,
        options
      )
    else
      signed_blob_id = model.blob.signed_id(expires_in: expires_in)
      variation_key  = model.variation.key
      filename       = model.blob.filename

      route_for(
        :rails_blob_representation,
        signed_blob_id,
        variation_key,
        filename,
        options
      )
    end
  end
end
