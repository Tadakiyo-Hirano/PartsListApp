class Users::ProductsController < ApplicationController
  # before_action :set_product, only: %i(edit update destroy)
  # before_action :set_user, only: %i(index)

  def index
    @user = current_user
    @brands = Brand.all.rank(:row_order)
    @categories = Category.rank(:row_order)
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    @heading_number = 0
  end

  def favorites
    @user = current_user
    @brands = Brand.all.rank(:row_order)
    @categories = Category.rank(:row_order)
    # @q = @user.favorited_products.ransack(params[:q])
    @products = @user.favorited_products.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    @heading_number = 0
    
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end
end
