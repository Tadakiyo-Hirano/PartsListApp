class Users::ProductsController < ApplicationController
  # before_action :set_product, only: %i(edit update destroy)
  # before_action :set_user, only: %i(index)

  def index
    @user = current_user
    @brands = Brand.all.rank(:row_order)
    @categories = Category.rank(:row_order)
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    @storage_size = Product.all.map {|product| product.document.byte_size}
    @heading_number = 0
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end
end
