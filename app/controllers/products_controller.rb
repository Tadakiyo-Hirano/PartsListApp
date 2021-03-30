class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    flash[:info] = @product
    redirect_to products_url
  end

  def edit
  end

  def update
  end

  def destroy
  end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:model, :category_id, :brand_id)
    end
end
