class ProductsController < ApplicationController
  def index
    @products = Product.all.order(model: :ASC)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "【#{@product.model}】を登録しました。"
      redirect_to products_url
    else
      flash[:danger] = @product.errors.full_messages.join
      redirect_to products_url
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.permit(:model, :category_id, :brand_id)
    end
end
