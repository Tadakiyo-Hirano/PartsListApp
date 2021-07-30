class Admins::ProductsController < ApplicationController
  before_action :set_product, only: %i(edit update destroy)
  before_action :set_user, only: %i(index)

  def index
    # @products = Product.all.order(model: :ASC)
    @q = Product.ransack(params[:q])
    @brands = Brand.all
    @categories = Category.all
    @products = @q.result.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    @storage_size = Product.all.map {|product| product.document.byte_size}
    
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "【#{@product.model}】を登録しました。"
      redirect_to request.referer
    else
      flash[:danger] = @product.errors.full_messages.join
      redirect_to request.referer
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
      redirect_to request.referer
    else
      flash[:danger] = @product.errors.full_messages.join
      redirect_to request.referer
    end
  end

  def destroy
    @product.destroy
      flash[:danger] = "パーツカタログ【#{@product.model}】を削除しました。"
      redirect_to request.referer
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:model, :category_id, :brand_id, :document)
    end
end
