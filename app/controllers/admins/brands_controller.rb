class Admins::BrandsController < ApplicationController
  protect_from_forgery except: :sort
  before_action :authenticate_admin!
  before_action :set_brand, only: %i(edit update)

  def index
    @brands = Brand.rank(:row_order)
    @heading_number = 0

    if params[:id].present?
      set_brand
    else
      @brand = Brand.new
    end
  end

  def index_sort
    @brands = Brand.rank(:row_order)
    @heading_number = 0
  end

  def sort
    brand = Brand.find(params[:brand_id])
    brand.update(brand_params)
    render body: nil
  end

  def new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:success] = "カテゴリー【#{@brand.name}】を登録しました。"
      redirect_to admins_brands_url
    else
      flash[:danger] = @brand.errors.full_messages.join
      redirect_to admins_brands_url
    end
  end

  def edit
  end

  def update
    @brand_updated_at = @brand.updated_at
    if @brand.update(brand_params)
      if @brand_updated_at != @brand.updated_at
        flash[:success] = "ブランド【#{@brand.name}】を更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to admins_brands_url
    else
      flash[:danger] = @brand.errors.full_messages.join
      redirect_to admins_brands_url(id: params[:id])
    end
  end

  def destroy_all
    @brands = Brand.where(id: params[:brands])
    if @brands.blank?
      flash[:warning] = "削除するブランドを選択してください。"
      redirect_to admins_brands_url
    else
      delete_count = @brands.map { |brand| }.count
      @brands.destroy_all
      flash[:danger] = "ブランドを#{delete_count}件削除しました。"
      redirect_to admins_brands_url
    end
  end

  private

    def set_brand
      @brand = Brand.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit(:name, :row_order_position)
    end
end
