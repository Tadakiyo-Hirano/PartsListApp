class UsersController < ApplicationController
  before_action :correct_user
  before_action :set_user, only: %i(show)

  def show
  end

  private

    def correct_user
      @user = current_user
      redirect_to(root_path) unless @user.id == current_user.id
    end
end
