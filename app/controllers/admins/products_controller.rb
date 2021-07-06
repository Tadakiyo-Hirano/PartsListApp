class Admins::ProductsController < ApplicationController
  before_action :set_product, only: %i(edit update destroy)
  before_action :set_user, only: %i(index)

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
      redirect_to admins_products_url
    else
      flash[:danger] = @product.errors.full_messages.join
      redirect_to admins_products_url
    end
  end

  def edit
  end

  def update
    @product_updated_at = @product.updated_at
    if @product.update(product_params)
      if @product_updated_at != @product.updated_at
        flash[:success] = "パーツカタログ【#{@product.model}】を更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to admins_products_url
    else
      flash[:danger] = @product.errors.full_messages.join
      redirect_to admins_products_url
    end
  end

  def destroy
    @product.destroy
      flash[:danger] = "パーツカタログ【#{@product.model}】を削除しました。"
    redirect_to admins_products_url
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:model, :category_id, :brand_id, :document)
    end
end
