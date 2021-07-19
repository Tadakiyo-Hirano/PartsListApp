class Admins::CategoriesController < ApplicationController
  protect_from_forgery except: :sort
  before_action :authenticate_admin!
  before_action :set_category, only: %i(edit update)

  def index
    @categories = Category.rank(:row_order)
    @heading_number = 0

    if params[:id].present?
      set_category
    else
      @category = Category.new
    end
  end

  def index_sort
    @categories = Category.rank(:row_order)
    @heading_number = 0
  end

  def sort
    category = Category.find(params[:category_id])
    category.update(category_params)
    render body: nil
  end

  def new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admins_categories_url, flash: { success: "カテゴリー【#{@category.name}】を登録しました。" }
    else
      redirect_to admins_categories_url, flash: { danger: @category.errors.full_messages.join }
    end
  end

  def edit
  end

  def update
    @category_updated_at = @category.updated_at
    if @category.update(category_params)
      if @category_updated_at != @category.updated_at
        flash[:success] = "カテゴリー【#{@category.name}】を更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to admins_categories_url
    else
      redirect_to admins_categories_url(id: params[:id]), flash: { danger: @category.errors.full_messages.join }
    end
  end

  def destroy_all
    @categories = Category.where(id: params[:categories])
    if @categories.blank?
      redirect_to admins_categories_path, flash: { warning: '削除するカテゴリーを選択してください。' }
    else
      delete_count = @categories.map { |category| }.count
      @categories.destroy_all
      redirect_to admins_categories_path, flash: { danger: "カテゴリーを#{delete_count}件削除しました。" }
    end
  rescue ActiveRecord::InvalidForeignKey
    redirect_to admins_brands_url, flash: { danger: 'パーツリストへ使用中のカテゴリは削除できません。' }
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :row_order_position)
    end
end