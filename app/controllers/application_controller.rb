class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可
  # before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加     
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後リダイレクト先
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admins_products_url
    else
      user_products_url(current_user)
    end
  end

  # ログアウト後リダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admin_session_url
    else
      root_url
    end
  end

  def new_notice
    @last_notice = Notice.where(display: true).order(posted_at: :DESC).first
  end

  private

    def set_user
      @user = current_user if user_signed_in?
    end

    def user_or_admin_signed_in?
      if user_signed_in? || admin_signed_in?
        return
      else
        redirect_to new_user_session_path
      end
    end

  protected

    def configure_permitted_parameters
      # 登録時にnameのストロングパラメータを追加
      # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

      # アカウント編集の時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :company_name])
    end
end
