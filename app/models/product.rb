class Product < ApplicationRecord
  has_one_attached :document
  belongs_to :brand
  belongs_to :category

  validates :model, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :brand_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # validate :category_id_that_does_not_exist
  # validate :brand_id_that_dose_not_exist

  # 登録するcategory_idの値が、紐づくCategoryのidの値に存在しない場合は無効にする。
  # def category_id_that_does_not_exist
  #   errors.add(:base, 'カテゴリー選択エラー') unless Category.find_by(id: category_id)
  # end

  # 登録するbrand_idの値が、紐づくBrandのidの値に存在しない場合は無効にする。
  # def brand_id_that_dose_not_exist
  #   errors.add(:base, 'ブランド選択エラー') unless Brand.find_by(id: brand_id)
  # end
end
