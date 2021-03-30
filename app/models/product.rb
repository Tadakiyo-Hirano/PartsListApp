class Product < ApplicationRecord
  validates :model, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :brand_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
