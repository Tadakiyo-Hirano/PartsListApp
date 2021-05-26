class Category < ApplicationRecord
  include RankedModel
  ranks :row_order
  has_many :products
  
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
end
