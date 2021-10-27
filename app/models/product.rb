class Product < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user # 中間テーブルを通じて他のテーブルにアクセスする

  has_one_attached :document
  belongs_to :brand
  belongs_to :category

  validates :model, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :document, attached: true,
                        content_type: { in: 'application/pdf', message: 'の形式が正しくありません' },
                        size: { less_than: 10.megabytes , message: 'のサイズは10MBまでにしてください' }

  scope :public_parts_list, -> (user) { joins(:brand).where("brands.public_level <= #{user.account_level}") }
end
