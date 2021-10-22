class Users::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(index favorites)
  before_action :set_brands, only: %i(index favorites)
  before_action :set_categories, only: %i(index favorites)
  before_action :new_notice, only: %i(index favorites)

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    @heading_number = 0
    # @notices = Notice.where(display: true).order(posted_at: :DESC)
    # @last_notice = Notice.where(display: true).order(posted_at: :DESC).first
  end

  def favorites
    @q = Product.ransack(params[:q])
    # @products = @q.result.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    # @q = @user.favorited_products.ransack(params[:q])

    @products = @user.favorited_products.includes(:brand, :category).page(params[:page]).per(20).order(model: :ASC)
    @heading_number = 0
    
  end

  private

    def set_brands
      @brands = Brand.all.rank(:row_order)
    end

    def set_categories
      @categories = Category.rank(:row_order)
    end
end
