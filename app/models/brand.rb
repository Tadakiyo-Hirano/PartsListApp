class Brand < ApplicationRecord
  include RankedModel
  ranks :row_order
  has_many :products
  
  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  enum public_level: { '1': 1, '2': 2, '3': 3, '4': 4, '5': 5 }

  scope :public_brands, -> (user) { where("brands.public_level <= #{user.account_level}") }
end
