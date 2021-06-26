class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可
  # before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加     
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admins_brands_url
    else
      products_url
    end
  end

  private

    def set_user
      @user = current_user if user_signed_in?
    end

  protected

    def configure_permitted_parameters
      # 登録時にnameのストロングパラメータを追加
      # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

      # アカウント編集の時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
end
