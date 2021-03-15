class CategoriesController < ApplicationController
  before_action :set_category, only: %i(show edit update)

  def index
    @categories = Category.all
  end

  def show
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "カテゴリー【#{@category.name}】を登録しました。"
      redirect_to categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update!(category_params)
      flash[:success] = "カテゴリー【#{@category.name}】を更新しました。"
      redirect_to categories_url
    else
      render :edit
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
      params.require(:category).permit(:name)
    end
end