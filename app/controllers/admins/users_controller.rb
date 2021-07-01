class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %i(show edit)
  
  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
