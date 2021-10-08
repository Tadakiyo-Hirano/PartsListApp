class Notice < ApplicationRecord
  validates :posted_at, presence: true
  validates :text, presence: true, length: { maximum: 300 }
end
