class Brand < ApplicationRecord
  include RankedModel
  ranks :row_order
  
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
end
