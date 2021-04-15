class UsersController < ApplicationController
  before_action :correct_user

  def show
    @user = User.find(params[:id])
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user.id == current_user.id
    end
end
