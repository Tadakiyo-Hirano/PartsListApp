class CategoriesController < ApplicationController
  protect_from_forgery :except => [:sort]
  before_action :set_category, only: %i(show edit update)

  def index
    @check
    # @category = Category.new
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

  def show
  end
  
  def new
    # @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリー【#{@category.name}】を登録しました。"
      redirect_to categories_url
    else
      flash[:danger] = @category.errors.full_messages.join
      redirect_to categories_url
    end
  end

  def edit
  end

  def update
    @category_updated_at = @category.updated_at
    if @category.update(category_params)
      if @category_updated_at != @category.updated_at
        @check = "aaa"
        flash[:success] = "カテゴリー【#{@category.name}】を更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to categories_url
    else
      flash[:danger] = @category.errors.full_messages.join
      redirect_to categories_url(id: params[:id])
    end
  end

  # def destroy
  # end

  def destroy_all
    @categories = Category.where(id: params[:categories])
    if @categories.blank?
      flash[:warning] = "削除するカテゴリーを選択してください。"
      redirect_to categories_path
    else
      delete_count = @categories.map { |category| }.count
      @categories.destroy_all
      flash[:danger] = "カテゴリーを#{delete_count}件削除しました。"
      redirect_to categories_path
    end
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :row_order_position)
    end
end