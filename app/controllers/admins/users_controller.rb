class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %i(show edit update)
  
  def index
    # @users = User.all.order(id: :ASC)
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(25).order(:id)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_user_path(@user), flash: { success: "#{@user.email}のアカウント情報を更新しました。" }
    else
      render :show, flash: { danger: @user.errors.full_messages }
    end
  end

  def favorite
    @user = User.find(params[:user_id])
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name)
    end
end
