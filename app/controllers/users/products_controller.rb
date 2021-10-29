class Users::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(index favorites)
  before_action :set_brands, only: %i(index favorites)
  before_action :set_categories, only: %i(index favorites)
  before_action :new_notice, only: %i(index favorites)

  def index
    @brands = Brand.public_brands(@user).rank(:row_order)
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:brand, :category).public_parts_list(@user).page(params[:page]).per(20).order(model: :ASC)
    @heading_number = 0
  end

  def favorites
    @q = Product.ransack(params[:q])
    @products = @user.favorited_products.includes(:brand, :category).public_parts_list(@user).page(params[:page]).per(20).order(model: :ASC)
    @heading_number = 0
    
  end

  private

    def set_brands
      @brands = Brand.public_brands(@user).rank(:row_order)
    end

    def set_categories
      @categories = Category.rank(:row_order)
    end
end
