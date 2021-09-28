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
      redirect_to admins_brands_url, flash: { success: "#{Brand.human_attribute_name :name}【#{@brand.name}】を登録しました。" }
    else
      redirect_to admins_brands_url, flash: { danger: @brand.errors.full_messages.join }
    end
  end

  def edit
  end

  def update
    @brand_updated_at = @brand.updated_at
    if @brand.update(brand_params)
      if @brand_updated_at != @brand.updated_at
        flash[:success] = "#{Brand.human_attribute_name :name}【#{@brand.name}】を更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to admins_brands_url
    else
      redirect_to admins_brands_url(id: params[:id]), flash: { danger: @brand.errors.full_messages.join }
    end
  end

  def destroy_all
    @brands = Brand.where(id: params[:brands])
    if @brands.blank?
      redirect_to admins_brands_url, flash: { warning: "削除する#{Brand.human_attribute_name :name}を選択してください。" }
    else
      delete_count = @brands.map { |brand| }.count
      @brands.destroy_all
      flash[:danger] = "#{Brand.human_attribute_name :name}を#{delete_count}件削除しました。"
      redirect_to admins_brands_url
    end
  rescue ActiveRecord::InvalidForeignKey
    redirect_to admins_brands_url, flash: { danger: "パーツリストへ使用中の#{Brand.human_attribute_name :name}は削除できません。" }
  end

  private

    def set_brand
      @brand = Brand.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit(:name, :row_order_position)
    end
end
