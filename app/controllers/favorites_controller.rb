class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def create
    product = Product.find(params[:product_id])
    favorite = Favorite.create(user_id: current_user.id, product_id: product.id)
    redirect_back(fallback_location: root_path, flash: { success: "#{product.model}をブックマーク登録しました。"})
  end

  def destroy
    product = Product.find(params[:product_id])
    favorite = Favorite.find_by(user_id: current_user.id, product_id: product.id)
    favorite.destroy
    redirect_back(fallback_location: root_path, flash: { danger: "#{product.model}のブックマークを解除しました。" })
  end
end
